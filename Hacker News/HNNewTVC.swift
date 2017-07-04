//
//  HNNewTVC.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 04/07/17.
//  Copyright © 2017 swiftobjc@gmail.com All rights reserved.
//

import UIKit

class HNNewTVC: UITableViewController {
    fileprivate static let kRowHeight: CGFloat = 70
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = kNewStory
        setupSkeletonTable()
    }
    
    func setupSkeletonTable () {
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        
        let nib = UINib(nibName: String(describing: HNStoriesTVC.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: HNStoriesTVC.self))
    }
    
    //MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(view.bounds.height/HNNewTVC.kRowHeight) + 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HNNewTVC.kRowHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HNStoriesTVC.self), for: indexPath) as! HNStoriesTVC
        
        cell.gradientLayers.forEach { gradientLayer in
            let baseColor = cell.titlePlaceholderView.backgroundColor!
            gradientLayer.colors = [baseColor.cgColor,
                                    baseColor.brightened(by: 0.93).cgColor,
                                    baseColor.cgColor]
        }
        
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let skeletonCell = cell as! HNStoriesTVC
        skeletonCell.slide(to: .right)
    }
}
