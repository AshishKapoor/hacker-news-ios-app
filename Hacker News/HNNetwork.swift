//
//  HNNetwork.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 05/07/17.
//  Copyright © 2017 Ashish Kapoor. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias StatsCompletionBlock = (_ stats: HNStories?, _ error: NSError?) -> ()

typealias StatsCompletionBlock1 = (_ stats: HNStoryId?, _ error: NSError?) -> ()


class HNNetwork {
    let session: URLSession
    init() {
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }
    
    class var sharedInstance: HNNetwork {
        struct Singleton {
            static let instance = HNNetwork()
        }
        return Singleton.instance
    }
    

    func getStoriesIds(url: String, _ completion: @escaping StatsCompletionBlock1) {
        guard let hnUrl = URL(string: url) else {return}
        let request = URLRequest(url: hnUrl)
        let task = session.dataTask(with: request) { data, response, dataError in
            if dataError == nil {
                do {
                    let statsDictionary = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    print(statsDictionary)
                    let storyIds: HNStoryId = HNStoryId(fromJSON: JSON(dictionary: statsDictionary))
                    completion(storyIds, nil)
                } catch {
                    completion(nil, error as NSError)
                }
            } else {
                completion(nil, dataError as NSError?)
            }
        }
        task.resume()
    }
    
    
    
    
    func getStoriesData(url: String, _ completion: @escaping StatsCompletionBlock) {
        guard let hnUrl = URL(string: url) else {return}
        let request = URLRequest(url: hnUrl)
        let task = session.dataTask(with: request) { data, response, dataError in
            if dataError == nil {
                do {
                    let statsDictionary = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    let stats: HNStories = HNStories(fromJSON: JSON(dictionary: statsDictionary))
                    completion(stats, nil)
                } catch {
                    completion(nil, error as NSError)
                }
            } else {
                completion(nil, dataError as NSError?)
            }
        }
        task.resume()
    }
}
