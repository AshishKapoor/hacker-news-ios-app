//
//  HNNewTVC.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 04/07/17.
//  Copyright © 2017 swiftobjc@gmail.com All rights reserved.
//

import UIKit
import Skeleton
import HNClient
import PullToRefresh

class HNNewTVC: UITableViewController {
    let dispatchGroup = DispatchGroup()
    var storiesCount: [Int] = [Int]()
    var pageNumber: Int = Int()
    var newStories = [HNItem]()
    let refresher = PullToRefresh()

    override func viewDidLoad() {
        super.viewDidLoad()
        pageNumber = kInitialValue
        self.navigationController?.navigationBar.topItem?.title = kNewStory
        setupTableView()
        HNManager.shared.fetchNewStoriesIds { [weak self] ids, error in
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
        for iteration in lowerValue...upperValue {
            dispatchGroup.enter()
            HNManager.shared.fetchItem(id: storiesCount[iteration]) { [weak self] response, error in
                guard let topStoryValues = response else  {return}
                self?.newStories.append(topStoryValues)
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
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let nib = UINib(nibName: String(describing: HNStoriesTVC.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: HNStoriesTVC.self))
    }
    
    //MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return kInitialValue
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.newStories.count {
        case 0:
            return 20
        default:
            return newStories.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.newStories.count <= 0 {
            return 70
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HNStoriesTVC.self), for: indexPath) as? HNStoriesTVC
            else {
                return UITableViewCell()
        }
        if self.newStories.count == 0 {
            cell.gradientLayers.forEach { gradientLayer in
                let baseColor = cell.titlePlaceholderView.backgroundColor!
                gradientLayer.colors = [baseColor.cgColor,
                                        baseColor.brightened(by: 0.93).cgColor,
                                        baseColor.cgColor]
            }
            return cell
        } else {
            
            cell.textLabel?.font = UIFont.systemFont(ofSize: kAppFontSize)
            cell.textLabel?.numberOfLines = 10
            cell.imagePlaceholderView.isHidden      = true
            cell.titlePlaceholderView.isHidden      = true
            cell.subtitlePlaceholderView.isHidden   = true
            
            tableView.isScrollEnabled = true
            tableView.separatorStyle = .singleLine
            
            if self.newStories[indexPath.row].title != nil {
                cell.textLabel?.text = self.newStories[indexPath.row].title
            }
            
            return cell
        }
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

private extension HNNewTVC {
    
    func setupPullToRefresh() {
        //        tableView.addPullToRefresh(PullToRefresh()) { [weak self] in
        //            let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        //            DispatchQueue.main.asyncAfter(deadline: delayTime) {
        //                self?.tableView.endRefreshing(at: .top)
        //            }
        //        }
        
        tableView.addPullToRefresh(PullToRefresh(position: .bottom)) { [weak self] in
            let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) {
                self?.reloadTable()
            }
        }
    }
}
