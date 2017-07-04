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
        self.tabBarItem.title = ""
        
        viewControllers = setupStoriesTVC()
        
        tabBar.isTranslucent = false
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        topBorder.backgroundColor = UIColor.red.cgColor
        
        
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
    }
    
    func setupStoriesTVC() -> [UINavigationController] {
        // New TVC
        let topStoriesNC = UINavigationController(rootViewController: HNTopTVC())
        topStoriesNC.title = kTopStory
        topStoriesNC.tabBarItem.image = UIImage(named: "topstory")
        topStoriesNC.tabBarItem.selectedImage = UIImage(named: "selected-topstory")
        // Best TVC
        let bestStoriesNC = UINavigationController(rootViewController: HNBestTVC())
        bestStoriesNC.title = kBestStory
        bestStoriesNC.tabBarItem.image = UIImage(named: "beststory")
        bestStoriesNC.tabBarItem.selectedImage = UIImage(named: "selected-beststory")
        // Top TVC
        let newStoriesNC = UINavigationController(rootViewController: HNNewTVC())
        newStoriesNC.title = kNewStory
        newStoriesNC.tabBarItem.image = UIImage(named: "newstory")
        newStoriesNC.tabBarItem.selectedImage = UIImage(named: "selected-newstory")
        
        return [topStoriesNC, bestStoriesNC, newStoriesNC]
    }
}
