//
//  HNStories.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 04/07/17.
//  Copyright © 2017 swiftobjc@gmail.com All rights reserved.
//

import Foundation
import SwiftyJSON

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
