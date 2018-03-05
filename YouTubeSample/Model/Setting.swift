//
//  Setting.swift
//  YouTubeSample
//
//  Created by Mohammad Farhoudi on 20/12/2017.
//  Copyright © 2017 Mohammad Farhoudi. All rights reserved.
//

import Foundation
import UIKit

public class Setting: NSObject {
    var title: SettingName
    var image: UIImage?
    
    
    init(title: SettingName, image: UIImage?) {
        self.title = title
        self.image = image

    }
}
