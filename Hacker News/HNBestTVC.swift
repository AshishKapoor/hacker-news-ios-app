//
//  FirstViewController.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 04/07/17.
//  Copyright © 2017 swiftobjc@gmail.com All rights reserved.
//

import UIKit
import Skeleton
import HNClient
import PullToRefresh

class HNBestTVC: UITableViewController {
    let dispatchGroup = DispatchGroup()
    var storiesCount: [Int] = [Int]()
    var pageNumber: Int = Int()
    var bestStories = [HNItem]()
    let refresher = PullToRefresh()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        pageNumber = kInitialValue
        self.navigationController?.navigationBar.topItem?.title = kBestStory
        setupTableView()
        HNManager.shared.fetchBestStoriesIds { [weak self] ids, error in
            self?.storiesCount = ids
            self?.loadStoriesData(page: kInitialValue)
        }
        setupPullToRefresh()
    }
    
    deinit {
        tableView.removePullToRefresh(refresher)
    }
    
    func loadStoriesData(page: Int) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let upperValue = page * 20
        let lowerValue = upperValue - 20
        for iteration in lowerValue..<upperValue {
            dispatchGroup.enter()
            HNManager.shared.fetchItem(id: storiesCount[iteration]) { [weak self] response, error in
                guard let topStoryValues = response else  {return}
                self?.bestStories.append(topStoryValues)
                self?.dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main, execute: {
            //all asynchronous tasks added to this DispatchGroup are completed. Proceed as required.
            self.reloadTable()
        })
    }
    
    func setupTableView() {
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let nib = UINib(nibName: String(describing: HNStoriesTVC.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: HNStoriesTVC.self))
    }
    
    //MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return kInitialValue
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.bestStories.count {
        case 0:
            return 20
        default:
            return bestStories.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if self.bestStories.count <= 0 {
//            return 120
//        } else {
            return UITableViewAutomaticDimension
//        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HNStoriesTVC.self), for: indexPath) as? HNStoriesTVC
            else {
                return UITableViewCell()
        }
        if self.bestStories.count == 0 {
            cell.gradientLayers.forEach { gradientLayer in
                let baseColor = cell.titlePlaceholderView.backgroundColor!
                gradientLayer.colors = [baseColor.cgColor,
                                        baseColor.brightened(by: 0.93).cgColor,
                                        baseColor.cgColor]
            }
            return cell
        } else {
            cell.storyTitle?.font = UIFont.systemFont(ofSize: kAppFontSize)
            cell.storyTitle?.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.storyTitle?.numberOfLines = 0
            
            cell.storySubTitle?.font = UIFont.systemFont(ofSize: 12)
            cell.storySubTitle?.numberOfLines = 1
            
            tableView.isScrollEnabled = true
            tableView.separatorStyle  = .singleLine
            
            cell.gradientLayers.forEach { gradientLayer in
                gradientLayer.colors = [0,0,0]
            }
            
            cell.imagePlaceholderView.backgroundColor       = UIColor.white
            cell.titlePlaceholderView.backgroundColor       = UIColor.white
            cell.subtitlePlaceholderView.backgroundColor    = UIColor.white
            
            if self.bestStories[indexPath.row].title != nil {
                let data = self.bestStories[indexPath.row]
                cell.storyTitle?.text = data.title
                cell.storySubTitle?.text = "\(String(describing: data.type!).capitalized) by \(String(describing: data.author!)): \(String(describing: timeAgoSinceDate(date: data.time! as NSDate, numericDates: true)))"
                cell.scoreTitle.text = "⇧\n\(String(describing: data.score!))"
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.bestStories[indexPath.row]
        let storyboard = UIStoryboard(name: "HackerStory", bundle: nil)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier :"HNStoryDetailTVC") as? HNStoryDetailTVC else {return}
        
        guard let safeType = data.type else {return}
        viewController.type = String(describing: safeType).capitalized
        
        guard let safeAuthor = data.author else {return}
        viewController.by = "\(String(describing: safeType).capitalized) By \(safeAuthor)"
        
        guard let safeTime = data.time as NSDate? else {return}
        viewController.time = timeAgoSinceDate(date: safeTime, numericDates: true)
        
        guard let safeUrl = data.url else {return}
        viewController.url = safeUrl.absoluteString
        
        guard let safeScore = data.score else {return}
        viewController.score = safeScore
        
        guard let safeTitle = data.title else {return}
        viewController.tit = safeTitle
        
        guard let safeId = data.id else {return}
        viewController.id = String(safeId)
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    //MARK: - UITableViewDelegate
    func reloadTable() {
        DispatchQueue.global(qos: .default).async {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.tableView.endRefreshing(at: .bottom)

            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let skeletonCell = cell as! HNStoriesTVC
        skeletonCell.slide(to: .right)
        if self.pageNumber < storiesCount.count/20 {
            let lastRowIndex = tableView.numberOfRows(inSection: 0)
            if indexPath.row == lastRowIndex - kInitialValue {
                self.pageNumber = self.pageNumber + kInitialValue
                loadStoriesData(page: self.pageNumber)
                tableView.startRefreshing(at: .bottom)
            }
        }
    }
}

private extension HNBestTVC {
    
    func setupPullToRefresh() {
        tableView.addPullToRefresh(PullToRefresh()) { [weak self] in
            let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) {
                self?.tableView.endRefreshing(at: .top)
            }
        }
        
        tableView.addPullToRefresh(PullToRefresh(position: .bottom)) { [weak self] in
            let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) {
                self?.reloadTable()
            }
        }
    }
}
