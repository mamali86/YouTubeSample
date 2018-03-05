//
//  TrendingCell.swift
//  YouTubeSample
//
//  Created by Mohammad Farhoudi on 23/01/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit

class TrendingCell: menuCell {
    
    override func fetchVideos() {
        
        
        ApiService.sharedInstance.fetchTrending { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
            self.collectionView.collectionViewLayout.invalidateLayout()
        
        
    }
    
    }
    
}
