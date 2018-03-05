//
//  Extensions.swift
//  YouTubeSample
//
//  Created by Mohammad Farhoudi on 16/12/2017.
//  Copyright © 2017 Mohammad Farhoudi. All rights reserved.
//

import Foundation
import UIKit




let imageCache = NSCache<AnyObject, AnyObject>()


class CustomImageView: UIImageView {
    
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        
        
        imageUrlString = urlString
        
        
        guard let url = URL(string: urlString) else {return}
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject){
            
            self.image = imageFromCache as? UIImage
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let err = error {
                print("Failed to retrive data: ", err)
                return
            }
//            guard let imageData = data else {return}
//            let image = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                
                let imageToCache = UIImage(data: data!)
                
                
                if self.imageUrlString ==  urlString {
                    
                      self.image = imageToCache
                    
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
            }
            }.resume()
        
        
        
        
    }
    
    
}

