//
//  HNConstants.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 04/07/17.
//  Copyright © 2017 swiftobjc@gmail.com All rights reserved.
//

import Foundation
import UIKit

let hNewsBaseUrl = "https://hacker-news.firebaseio.com/v0/"

enum StoryType {
    case bestStories, topStory, newStory
}

let kBestStory      = "Best Stories"
let kTopStory       = "Top Stories"
let kNewStory       = "New Stories"
let kEmptyString    = ""

enum AppTheme {
    case orange, black
}

let kEdgeInset: UIEdgeInsets       = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
