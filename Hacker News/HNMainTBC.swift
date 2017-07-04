//
//  HNMainTBC.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 04/07/17.
//  Copyright © 2017 swiftobjc@gmail.com All rights reserved.
//

import UIKit

class HNMainTBC: UITabBarController {
    let initialColor: AppTheme                  = AppTheme.black // TODO: - Hardcoded
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupAppTheme(color: initialColor)
        viewControllers                         = setupStoriesTVC()
    }

    func setupTabBar() {
        let topBorder                           = CALayer()
        topBorder.frame                         = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        topBorder.backgroundColor               = UIColor.orange.cgColor
        tabBar.layer.addSublayer(topBorder)
    }
    
    func setupAppTheme(color: AppTheme) {
        switch initialColor {
        case AppTheme.orange:
            tabBar.barTintColor                 = UIColor.orange
            tabBar.tintColor                    = UIColor.white
            if #available(iOS 10.0, *) {
                tabBar.unselectedItemTintColor  = UIColor.white
            } else {} // TODO: - Fallback on earlier versions
            
        case AppTheme.black:
            tabBar.barTintColor                 = .black
            tabBar.tintColor                    = UIColor.white
            if #available(iOS 10.0, *) {
                tabBar.unselectedItemTintColor  = UIColor.white
            } else {} // TODO: - Fallback on earlier versions
        }
        tabBar.clipsToBounds                    = true
        tabBar.isTranslucent                    = false
    }
    
    func setupStoriesTVC() -> [UINavigationController] {
        
        let topStoriesNC                        = UINavigationController(rootViewController: HNTopTVC())
        topStoriesNC.tabBarItem.image           = UIImage(named: "topstory")
        topStoriesNC.tabBarItem.selectedImage   = UIImage(named: "selected-topstory")
        topStoriesNC.tabBarItem.imageInsets     = kEdgeInset
        topStoriesNC.tabBarItem.title           = kEmptyString
        
        topStoriesNC.navigationBar.barStyle             = .black
        topStoriesNC.navigationBar.isTranslucent        = false
        topStoriesNC.navigationBar.titleTextAttributes  = [NSForegroundColorAttributeName: UIColor.white]
        
        let bestStoriesNC                       = UINavigationController(rootViewController: HNBestTVC())
        bestStoriesNC.tabBarItem.image          = UIImage(named: "beststory")
        bestStoriesNC.tabBarItem.selectedImage  = UIImage(named: "selected-beststory")
        bestStoriesNC.tabBarItem.imageInsets    = kEdgeInset
        bestStoriesNC.tabBarItem.title          = kEmptyString
        
        bestStoriesNC.navigationBar.barStyle             = .black
        bestStoriesNC.navigationBar.isTranslucent        = false
        bestStoriesNC.navigationBar.titleTextAttributes  = [NSForegroundColorAttributeName: UIColor.white]
        
        
        let newStoriesNC                        = UINavigationController(rootViewController: HNNewTVC())
        newStoriesNC.tabBarItem.image           = UIImage(named: "newstory")
        newStoriesNC.tabBarItem.selectedImage   = UIImage(named: "selected-newstory")
        newStoriesNC.tabBarItem.imageInsets     = kEdgeInset
        newStoriesNC.tabBarItem.title           = kEmptyString
        
        newStoriesNC.navigationBar.barStyle             = .black
        newStoriesNC.navigationBar.isTranslucent        = false
        newStoriesNC.navigationBar.titleTextAttributes  = [NSForegroundColorAttributeName: UIColor.white]
        
        return [topStoriesNC, bestStoriesNC, newStoriesNC]
    }
}
