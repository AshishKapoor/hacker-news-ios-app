//
//  HNConstants.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 04/07/17.
//  Copyright © 2017 swiftobjc@gmail.com All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds

enum typeOfStories {
    case topstories, beststories, newStories
}


let hnStoryBaseUrl = "https://hacker-news.firebaseio.com/v0/"
let hnPrettyJson = ".json?print=pretty"

let kTopStories = "\(hnStoryBaseUrl)\(typeOfStories.topstories)\(hnPrettyJson)"
let kBestStories = "\(hnStoryBaseUrl)\(typeOfStories.beststories)\(hnPrettyJson)"
let kNewStories = "\(hnStoryBaseUrl)\(typeOfStories.newStories)\(hnPrettyJson)"

let hnStoryBaseItemUrl = "https://hacker-news.firebaseio.com/v0/item/"

let kInitialValue = 1
let kAppFontSize: CGFloat = 17

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
let requestGAD = GADRequest()

func timeAgoSinceDate(date:NSDate, numericDates:Bool) -> String {
    let calendar = NSCalendar.current
    let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
    let now = NSDate()
    let earliest = now.earlierDate(date as Date)
    let latest = (earliest == now as Date) ? date : now
    let components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
    
    if (components.year! >= 2) {
        return "\(components.year!) years ago"
    } else if (components.year! >= 1){
        if (numericDates){
            return "1 year ago"
        } else {
            return "Last year"
        }
    } else if (components.month! >= 2) {
        return "\(components.month!) months ago"
    } else if (components.month! >= 1){
        if (numericDates){
            return "1 month ago"
        } else {
            return "Last month"
        }
    } else if (components.weekOfYear! >= 2) {
        return "\(components.weekOfYear!) weeks ago"
    } else if (components.weekOfYear! >= 1){
        if (numericDates){
            return "1 week ago"
        } else {
            return "Last week"
        }
    } else if (components.day! >= 2) {
        return "\(components.day!) days ago"
    } else if (components.day! >= 1){
        if (numericDates){
            return "1 day ago"
        } else {
            return "Yesterday"
        }
    } else if (components.hour! >= 2) {
        return "\(components.hour!) hours ago"
    } else if (components.hour! >= 1){
        if (numericDates){
            return "1 hour ago"
        } else {
            return "An hour ago"
        }
    } else if (components.minute! >= 2) {
        return "\(components.minute!) minutes ago"
    } else if (components.minute! >= 1){
        if (numericDates){
            return "1 minute ago"
        } else {
            return "A minute ago"
        }
    } else if (components.second! >= 3) {
        return "\(components.second!) seconds ago"
    } else {
        return "Just now"
    }
    
}

// Copyright stuff
let rfAboutViewCopyright =
    "Copyright (c) 2016 René Fouquet <mail@fouquet.me>\n\n" +
        
    "Permission is hereby granted, free of charge, to any person obtaining a copy" +
    "of this software and associated documentation files (the \"Software\"), to deal" +
    "in the Software without restriction, including without limitation the rights" +
    "to use, copy, modify, merge, publish, distribute, sublicense, and/or sell" +
    "copies of the Software, and to permit persons to whom the Software is" +
    "furnished to do so, subject to the following conditions:" +
    "\n\n" +
    "The above copyright notice and this permission notice shall be included in" +
    "all copies or substantial portions of the Software." +
    "\n\n" +
    "THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR" +
    "IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY," +
    "FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE" +
    "AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER" +
    "LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM," +
    "OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN" +
    "THE SOFTWARE."

let hnClientCopyRight =
    "Copyright (c) 2016-2017 Omar Albeik (https://github.com/omaralbeik)\n\n" +
    
    "Permission is hereby granted, free of charge, to any person obtaining a copy" +
    "of this software and associated documentation files (the \"Software\"), to deal" +
    ":in the Software without restriction, including without limitation the rights" +
    "to use, copy, modify, merge, publish, distribute, sublicense, and/or sell" +
    "copies of the Software, and to permit persons to whom the Software is" +
    "furnished to do so, subject to the following conditions:\n\n" +
    
    "The above copyright notice and this permission notice shall be included in" +
    "all copies or substantial portions of the Software.\n\n" +
    
    "THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR" +
    "IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY," +
    "FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE" +
    "AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER" +
    "LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM," +
    "OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN" +
    "THE SOFTWARE."

let swiftyJSONCopyRight =
    "The MIT License (MIT)\n\n" +

    "Copyright (c) 2017 Ruoyu Fu\n\n" +

    "Permission is hereby granted, free of charge, to any person obtaining a copy" +
    "of this software and associated documentation files (the \"Software\"), to deal" +
    "in the Software without restriction, including without limitation the rights" +
    "to use, copy, modify, merge, publish, distribute, sublicense, and/or sell" +
    "copies of the Software, and to permit persons to whom the Software is" +
    "furnished to do so, subject to the following conditions:\n\n" +

    "The above copyright notice and this permission notice shall be included in" +
    "all copies or substantial portions of the Software.\n\n" +

    "THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR" +
    "IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY," +
    "FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE" +
    "AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER" +
    "LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM," +
    "OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN" +
    "THE SOFTWARE."

let twitterCopyRight =
"Copyright 2015 Twitter, Inc.\n\n" +
"Licensed under the Apache License, Version 2.0: http://www.apache.org/licenses/LICENSE-2.0"

let pullToRefreshCopyRight = 
    "The MIT License (MIT)\n\n" +

    "Copyright © 2017 Yalantis\n\n" +

    "Permission is hereby granted, free of charge, to any person obtaining a copy" +
    "of this software and associated documentation files (the \"Software\"), to deal" +
    "in the Software without restriction, including without limitation the rights" +
    "to use, copy, modify, merge, publish, distribute, sublicense, and/or sell" +
    "copies of the Software, and to permit persons to whom the Software is" +
    "furnished to do so, subject to the following conditions:\n\n" +

    "The above copyright notice and this permission notice shall be included in" +
    "all copies or substantial portions of the Software.\n\n" +

    "THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR" +
    "IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY," +
    "FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE" +
    "AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER" +
    "LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM," +
    "OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN" +
    "THE SOFTWARE."
