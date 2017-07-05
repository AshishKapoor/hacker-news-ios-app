//
//  HNNetwork.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 05/07/17.
//  Copyright © 2017 Ashish Kapoor. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias storiesDataCompletion = (_ stats: HNStories?, _ error: NSError?) -> ()
typealias storiesIdCompletion = (_ stats: HNStoryId?, _ error: NSError?) -> ()

class HNNetworkServices {
    let session: URLSession
    init() {
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }
    
    class var sharedInstance: HNNetworkServices {
        struct Singleton {
            static let instance = HNNetworkServices()
        }
        return Singleton.instance
    }

    func getStoriesIds(url: String, _ completion: @escaping storiesIdCompletion) {
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
    
    
    
    
    func getStoriesData(url: String, _ completion: @escaping storiesDataCompletion) {
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
