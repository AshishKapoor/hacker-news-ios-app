//
//  HNStoryId.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 05/07/17.
//  Copyright © 2017 Ashish Kapoor. All rights reserved.
//

import Foundation
import SwiftyJSON

class HNStoryId : NSObject, NSCoding {
    
    let storyId: Int
    
    init(fromJSON json: JSON) {
        storyId = json.intValue
    }
    
    required public init(coder aDecoder: NSCoder)  {
        storyId = aDecoder.decodeObject() as! Int
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(storyId)
    }
}
