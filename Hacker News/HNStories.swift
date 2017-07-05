//
//  HNStories.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 04/07/17.
//  Copyright © 2017 swiftobjc@gmail.com All rights reserved.
//

import Foundation
import SwiftyJSON

open class HNStories : NSObject, NSCoding {

    open let by: String
    open let score: Int
    open let time: Date
    open let title: String
//    open let descendants: Int
//    open let id: Int
//    open let kids: [Int]
//    open let type: String
//    open let url: String
    
    override open var description: String {
        return "\(title) By \(by) at \(time)"
    }
    
    public init(fromJSON json: JSON) {
        title = json["title"].string!
        by    = json["by"].string!
        score = json["score"].int!
        
        let timeInterval :TimeInterval = json["time"].double!
        let timezoneBump = Double(-TimeZone.current.secondsFromGMT())
        time = Date(timeIntervalSince1970: timeInterval + timezoneBump)
    }
    
    public required init(coder aDecoder: NSCoder)  {
        title = (aDecoder.decodeObject(forKey: "title") as! NSString) as String
        by    = (aDecoder.decodeObject(forKey: "by") as! NSString) as String
        score = (aDecoder.decodeObject(forKey: "score") as! Int) as Int
        time = aDecoder.decodeObject(forKey: "time") as! Date
    }
    
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(by, forKey: "by")
        aCoder.encode(score, forKey: "score")
        aCoder.encode(time, forKey: "time")
    }
    
}



