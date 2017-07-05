//
//  HNConstants.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 04/07/17.
//  Copyright © 2017 swiftobjc@gmail.com All rights reserved.
//

import Foundation
import UIKit

enum typeOfStories {
    case topstories, beststories, newStories
}

let hnStoryBaseUrl = "https://hacker-news.firebaseio.com/v0/"
let hnPrettyJson = ".json?print=pretty"

let kTopStories = "\(hnStoryBaseUrl)\(typeOfStories.topstories)\(hnPrettyJson)"
let kBestStories = "\(hnStoryBaseUrl)\(typeOfStories.beststories)\(hnPrettyJson)"
let kNewStories = "\(hnStoryBaseUrl)\(typeOfStories.newStories)\(hnPrettyJson)"

let hnStoryBaseItemUrl = "https://hacker-news.firebaseio.com/v0/item/" // "\($item)\($hnPrettyJson)"

let kAppFontSize: CGFloat = 13

let kTopStoriesUrl = "https://hacker-news.firebaseio.com/v0/item/14693127.json?print=pretty"
let kurl = "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty"

enum StoryType {
    case bestStories, topStory, newStory
}

let kBestStory      = "Best Stories"
let kTopStory       = "Top Stories"
let kNewStory       = "New Stories"
let kTwitterFeed    = "Twitter Feed"
let kEmptyString    = ""

enum AppTheme {
    case orange, black
}

let kEdgeInset: UIEdgeInsets       = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
let kRowHeight: CGFloat = 70
