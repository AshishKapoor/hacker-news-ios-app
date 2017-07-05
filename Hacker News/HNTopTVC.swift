//
//  HNTopTVC.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 04/07/17.
//  Copyright © 2017 Ashish Kapoor. All rights reserved.
//

import UIKit
import Skeleton

class HNTopTVC: UITableViewController {
    fileprivate static let kRowHeight: CGFloat = 70
    var stories = [HNStories]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = kTopStory        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchStories { error in
            if error == nil {
                self.tableView.reloadData()
            }
        }
    }
    
    func fetchStories(_ completion: @escaping (_ error: Error?) -> ()) {
        HNNetwork.sharedInstance.getStoriesIds(url: kurl) { stories, error in
            DispatchQueue.main.async {
//                self.stories.append(stories!)
                if error == nil {
                    completion(error)
                }
            }
        }
        
        HNNetwork.sharedInstance.getStoriesData(url: kTopStoriesUrl) { stories, error in
            DispatchQueue.main.async {
                self.stories.append(stories!)
                if error == nil {
                    completion(error)
                }
            }
        }
    }
    
    func setupTableView() {
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        
        let nib = UINib(nibName: String(describing: HNStoriesTVC.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: HNStoriesTVC.self))
    }
    
    //MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.stories.count {
        case 0:
            return Int(view.bounds.height/HNTopTVC.kRowHeight) + 1
        default:
            return stories.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HNTopTVC.kRowHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HNStoriesTVC.self), for: indexPath) as? HNStoriesTVC
            else {
                return UITableViewCell()
            }
        
        if self.stories.count == 0 {
            cell.gradientLayers.forEach { gradientLayer in
                let baseColor = cell.titlePlaceholderView.backgroundColor!
                gradientLayer.colors = [baseColor.cgColor,
                                        baseColor.brightened(by: 0.93).cgColor,
                                        baseColor.cgColor]
            }
            return cell
        } else {
            cell.imagePlaceholderView.isHidden      = true
            cell.titlePlaceholderView.isHidden      = true
            cell.subtitlePlaceholderView.isHidden   = true
            tableView.isScrollEnabled = true
            tableView.separatorStyle = .singleLine

            cell.textLabel?.text = stories[indexPath.row].title
            return cell
        }
    }
    
    //MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let skeletonCell = cell as! HNStoriesTVC
        skeletonCell.slide(to: .right)
    }
}

