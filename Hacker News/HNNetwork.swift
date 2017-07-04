//
//  HNNetwork.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 05/07/17.
//  Copyright © 2017 Ashish Kapoor. All rights reserved.
//

import Foundation

func loadData() {
    let task = URLSession.shared.dataTask(with: NSURL(string: "http://httpbin.org/get")! as URL, completionHandler: { (data, response, error) -> Void in
        do{
            let str = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            print(str)
        } catch {
            fatalError("json error: \(error)")
        }
    })
    task.resume()
}
