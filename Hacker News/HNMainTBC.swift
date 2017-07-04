//
//  HNMainTBC.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 04/07/17.
//  Copyright © 2017 swiftobjc@gmail.com All rights reserved.
//

import UIKit

class HNMainTBC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = setupStoriesTVC()
        setupTabBar()
    }
    
    func setupStoriesTVC() -> [UINavigationController] {
        
        let topStoriesNC = UINavigationController(rootViewController: HNTopTVC())
        topStoriesNC.title = kTopStory
        topStoriesNC.tabBarItem.image = UIImage(named: "topstory")
        topStoriesNC.tabBarItem.selectedImage = UIImage(named: "selected-topstory")
        topStoriesNC.tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
        topStoriesNC.tabBarItem.title = ""
        
        let bestStoriesNC = UINavigationController(rootViewController: HNBestTVC())
        bestStoriesNC.title = kBestStory
        bestStoriesNC.tabBarItem.image = UIImage(named: "beststory")
        bestStoriesNC.tabBarItem.selectedImage = UIImage(named: "selected-beststory")
        bestStoriesNC.tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
        bestStoriesNC.tabBarItem.title = ""
        
        let newStoriesNC = UINavigationController(rootViewController: HNNewTVC())
        newStoriesNC.title = kNewStory
        newStoriesNC.tabBarItem.image = UIImage(named: "newstory")
        newStoriesNC.tabBarItem.selectedImage = UIImage(named: "selected-newstory")
        newStoriesNC.tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
        newStoriesNC.tabBarItem.title = ""
        
        return [topStoriesNC, bestStoriesNC, newStoriesNC]
    }
    
    func setupTabBar() {
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        topBorder.backgroundColor = UIColor.red.cgColor
        
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
        tabBar.isTranslucent = false
    }
}
