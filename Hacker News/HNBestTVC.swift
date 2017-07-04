//
//  FirstViewController.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 04/07/17.
//  Copyright © 2017 swiftobjc@gmail.com All rights reserved.
//

import UIKit
import Skeleton

class HNBestTVC: UITableViewController {
    fileprivate static let kRowHeight: CGFloat = 70
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = kBestStory
        self.tabBarItem.title = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupSkeletonTable()
    }
    
    func setupSkeletonTable() {
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        
        let nib = UINib(nibName: String(describing: HNStoriesTVC.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: HNStoriesTVC.self))
    }
    
    func loadData() {
        let task = URLSession.shared.dataTask(with: NSURL(string: "http://httpbin.org/get")! as URL, completionHandler: { (data, response, error) -> Void in
            do{
                let str = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
                print(str)
            } catch {
                fatalError("json error: \(error)")
            }
        })
        task.resume()
    }
}

extension HNBestTVC {
    
    //MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(view.bounds.height/HNBestTVC.kRowHeight) + 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HNBestTVC.kRowHeight
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
