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

class HNNewTVC: UITableViewController {
    private var topStories = [HNItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = kNewStory
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if topStories.count > 0 {
            topStories.removeAll()
            tableView.reloadData()
        }
        
        
        HNManager.shared.fetchNewStoriesIds { [weak self] ids, error in
            self?.loadMore(urlValues: ids)
        }
    }
    
    func loadMore(urlValues: [Int]) {
        for i in 0..<urlValues.count-480 {
            HNManager.shared.fetchItem(id: urlValues[i]) { response, error in
                guard let topStoryValues = response else  {return}
                self.topStories.append(topStoryValues)
                self.tableView.reloadData()
            }
        }
    }
    
    
    func setupTableView() {
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let nib = UINib(nibName: String(describing: HNStoriesTVC.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: HNStoriesTVC.self))
    }
    
    //MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.topStories.count {
        case 0:
            return 10
        default:
            return topStories.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.topStories.count <= 0 {
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
        if self.topStories.count == 0 {
            cell.gradientLayers.forEach { gradientLayer in
                let baseColor = cell.titlePlaceholderView.backgroundColor!
                gradientLayer.colors = [baseColor.cgColor,
                                        baseColor.brightened(by: 0.93).cgColor,
                                        baseColor.cgColor]
            }
            return cell
        } else {
            
            cell.textLabel?.font = UIFont.systemFont(ofSize: 10)
            cell.textLabel?.numberOfLines = 10
            cell.imagePlaceholderView.isHidden      = true
            cell.titlePlaceholderView.isHidden      = true
            cell.subtitlePlaceholderView.isHidden   = true
            
            tableView.isScrollEnabled = true
            tableView.separatorStyle = .singleLine
            
            if self.topStories[indexPath.row].title != nil {
                cell.textLabel?.text = self.topStories[indexPath.row].title
            }
            
            return cell
        }
    }
    
    //MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let skeletonCell = cell as! HNStoriesTVC
        skeletonCell.slide(to: .right)
    }
}

