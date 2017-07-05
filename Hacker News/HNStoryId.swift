//
//  HNStoryId.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 05/07/17.
//  Copyright © 2017 Ashish Kapoor. All rights reserved.
//

import Foundation
import SwiftyJSON

open class HNStoryId : NSObject, NSCoding {
    
    open let storyId: Int
    
    public init(fromJSON json: JSON) {
        storyId = json.intValue
    }
    
    public required init(coder aDecoder: NSCoder)  {
        storyId = aDecoder.decodeObject() as! Int
    }
    
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(storyId)
    }
}
