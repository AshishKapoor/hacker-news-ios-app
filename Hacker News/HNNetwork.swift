//
//  HNNetwork.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 05/07/17.
//  Copyright © 2017 Ashish Kapoor. All rights reserved.
//

import Foundation

class HNNetwork {
    public enum HTTPMethod: String {
        case GET    = "GET"
        case POST   = "POST"
        case PUT    = "PUT"
        case DELETE = "DELETE"
    }
    
    func loadData(url: String) {
        guard let hnUrl = URL(string: url) else {return}
        let task = URLSession.shared.dataTask(with: hnUrl, completionHandler: { (data, response, error) -> Void in
            do{
                let option = JSONSerialization.ReadingOptions.allowFragments
                guard let str = try JSONSerialization.jsonObject(with: data!, options: option) as? JSONDictionary else {return}
                //            print(str)
            } catch {fatalError("json error: \(error)")}
        })
        task.resume()
    }
}
