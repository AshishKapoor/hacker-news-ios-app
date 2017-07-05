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

class HNBestTVC: UITableViewController {
    private var bestStories = [HNItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = kBestStory
        setupTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if bestStories.count > 0 {
            bestStories.removeAll()
        }
        
        HNManager.shared.fetchBestStoriesIds { ids in
            for i in 0..<(ids.0.count)-150 {
                HNManager.shared.fetchItem(id: i) { item, error in
                    guard let items = item else {return}
                    self.bestStories.append(items)
                    self.tableView.reloadData()
                }
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
        switch self.bestStories.count {
        case 0:
            return 10
        default:
            return bestStories.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.bestStories.count <= 0 {
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
        if self.bestStories.count == 0 {
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
            
            //            cell.imagePlaceholderView.isHidden      = true
            //            cell.titlePlaceholderView.isHidden      = true
            //            cell.subtitlePlaceholderView.isHidden   = true
            
            
            tableView.isScrollEnabled = true
            tableView.separatorStyle = .singleLine
            
            if self.bestStories[indexPath.row].title == nil {
                
            } else {
                
                cell.textLabel?.text = self.bestStories[indexPath.row].title
                cell.detailTextLabel?.text = String(describing: self.bestStories[indexPath.row].time)
                
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

