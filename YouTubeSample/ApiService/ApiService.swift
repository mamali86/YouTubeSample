//
//  ApiService.swift
//  YouTubeSample
//
//  Created by Mohammad Farhoudi on 09/01/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    
    static let sharedInstance = ApiService()
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlstring: "\(baseUrl)/home.json", completion: completion)
        
    }
    
    
    
    func fetchTrending(completion: @escaping ([Video]) -> ()) {
        
        fetchFeedForUrlString(urlstring: "\(baseUrl)/trending.json", completion: completion)
        
    }
    
    
    func fetchSubscription(completion: @escaping ([Video]) -> ()) {
        
        
        fetchFeedForUrlString(urlstring: "\(baseUrl)/subscriptions.json", completion: completion)

        
    }
    
    func fetchFeedForUrlString(urlstring: String , completion:  @escaping ([Video]) -> ()) {
        
        
        
        if let url = URL(string: urlstring) {
            
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let err = error {
                    print("Failed to fetch the videos", err)
                    return
                }
                
                guard let  data = data else {return}
                
                
                do {
                    
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    
                    guard let videoDictionaries = json as? [[String: Any]] else {return}
                    
                    var videos = [Video]()
                    
                    for videoDictionary in videoDictionaries {
                        
                        
                        let video = Video(dictionary: videoDictionary)
                        
//
//                        video.title = videoDictionary["title"] as? String
//                        video.thumbnail_image_name = videoDictionary["thumbnail_image_name"]  as? String
//                        video.number_of_views = videoDictionary["number_of_Views"] as? NSNumber
//                        video.setValuesForKeysWithDictionary(videoDictionary)
                        
                
                        let channelDictionary = videoDictionary["channel"] as! [String: AnyObject]
                        
                        let channel = Channel(dictionary: channelDictionary)
                        video.channel = channel
                        videos.append(video)
//                        let channelDictionary = videoDictionary["channel"] as! [String: AnyObject]
//                        channel.name = channelDictionary["name"] as? String
//                        channel.profile_image_name = channelDictionary["profile_image_name"] as? String
                    
                    }
                                    
                    DispatchQueue.main.async {

                        completion(videos)
//                         completion(videoDictionaries.map({return Video(dictionary: $0)}))

                    }
                    
                    
                } catch let jsonError {
                    print("Failed to parse JSON properly:", jsonError)
                    
                }
            }).resume()
            
        
        
    }
    

    
    
    }
    
    
    

}
