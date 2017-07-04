//
//  HNMainNC.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 04/07/17.
//  Copyright © 2017 swiftobjc@gmail.com All rights reserved.
//

import UIKit

class HNMainNC: UINavigationController {
    
    let initialColor: AppTheme = AppTheme.orange // TODO: - Hardcoded 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppTheme(color: initialColor)
    }

    func setupAppTheme(color: AppTheme) {
        switch initialColor {
        case AppTheme.orange:
            self.navigationBar.barTintColor             = UIColor.orange
            self.navigationBar.tintColor                = UIColor.white
            self.tabBarController?.tabBar.barTintColor  = UIColor.orange
            self.tabBarController?.tabBar.tintColor     = UIColor.white
            if #available(iOS 10.0, *) {
                self.tabBarController?.tabBar.unselectedItemTintColor  = UIColor.white
            } else {
                // TODO: - Fallback on earlier versions
            }

        case AppTheme.black:
            self.navigationBar.barTintColor             = UIColor.black
            self.navigationBar.tintColor                = UIColor.white
            self.tabBarController?.tabBar.barTintColor  = UIColor.black
            self.tabBarController?.tabBar.tintColor     = UIColor.white
            if #available(iOS 10.0, *) {
                self.tabBarController?.tabBar.unselectedItemTintColor  = UIColor.white
            } else {
                // TODO: - Fallback on earlier versions
            }
        }
    }
}
