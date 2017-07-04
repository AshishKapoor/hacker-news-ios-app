//
//  HNStories.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 04/07/17.
//  Copyright © 2017 Ashish Kapoor. All rights reserved.
//

import Foundation
import SwiftyJSON
/*
{
    "by": "johngrib",
    "descendants": 9,
    "id": 14693127,
    "kids": [
    14693554,
    14693397
    ],
    "score": 84,
    "time": 1499135972,
    "title": "Block-breaking game in vim 8.0",
    "type": "story",
    "url": "https://github.com/johngrib/vim-game-code-break"
}
*/

struct HNStories {
    var by: String
    var descendants: Int
    var id: Int
    var kids: [Int]
    var score: Int
    var time: Date
    var title: String
    var type: String
    var url: String
}
