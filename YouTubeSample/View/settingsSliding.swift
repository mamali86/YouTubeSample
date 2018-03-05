//
//  settings.swift
//  YouTubeSample
//
//  Created by Mohammad Farhoudi on 20/12/2017.
//  Copyright © 2017 Mohammad Farhoudi. All rights reserved.
//

import Foundation
import UIKit


class settingsSliding: BaseCell {
    
    override var isHighlighted: Bool {
        
        didSet{
            //                TERNARY OPERATOR
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            
            settingsLabel.textColor =  isHighlighted ? UIColor.white : UIColor.black
            
            imageSettings.tintColor =  isHighlighted ? UIColor.white : UIColor.darkGray
            
        }
    }
    
    
    
    
    var setting: Setting? {
        
    didSet {
        settingsLabel.text = setting?.title.rawValue
        imageSettings.image = setting?.image
        imageSettings.tintColor = UIColor.darkGray
    }
    }
    
    let settingsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "Settings"
        return label
    }()
    
    
    
    let imageSettings: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "settings").withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.init(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        return image
    }()
    
    
    
    
    
    
    
    
    override func setupviews() {
        super.setupviews()
        
        
        addSubview(imageSettings)
        
        imageSettings.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageSettings.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageSettings.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        imageSettings.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        addSubview(settingsLabel)
        
        settingsLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true
        settingsLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        settingsLabel.leftAnchor.constraint(equalTo: imageSettings.rightAnchor, constant: 5).isActive = true
        settingsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
    
}


