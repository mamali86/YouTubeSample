//
//  Video.swift
//  YouTubeSample
//
//  Created by Mohammad Farhoudi on 11/12/2017.
//  Copyright © 2017 Mohammad Farhoudi. All rights reserved.
//

import Foundation
import UIKit

 class Video {

    
    var title: String?
    var thumbnail_image_name: String?
    var channel: Channel?
    var number_of_views: NSNumber?
    var date: NSDate?
    
    var duration: NSNumber?
    
    
    init(dictionary :[String: Any]) {
        
        self.title = dictionary["title"] as? String ?? ""
        self.thumbnail_image_name = dictionary["thumbnail_image_name"] as? String ?? ""
        self.number_of_views = dictionary["number_of_views"] as? NSNumber
    }
    
    

}



 class Channel {
    
    
    var name: String?
    
     var profile_image_name: String?
    
    
    init(dictionary :[String: Any]) {
        
        self.name = dictionary["name"] as? String
        self.profile_image_name = dictionary["profile_image_name"] as? String
        
    }
    
    

    
}

