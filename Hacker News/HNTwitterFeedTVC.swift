//
//  HNTwitterFeedTVC.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 06/07/17.
//  Copyright © 2017 Ashish Kapoor. All rights reserved.
//

import UIKit
import TwitterKit

class HNTwitterFeedTVC: TWTRTimelineViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = kTwitterFeed
        let client = TWTRAPIClient()
        self.dataSource = TWTRListTimelineDataSource(listSlug: "Hackers-News", listOwnerScreenName: "swiftobjc", apiClient: client)
    }
}
