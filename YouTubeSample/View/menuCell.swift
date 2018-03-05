//
//  menuCell.swift
//  YouTubeSample
//
//  Created by Mohammad Farhoudi on 12/01/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit
import Foundation

class menuCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    
    let cellid = "Cellid"

    
     lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
        
    }()
    
    
    var videos: [Video]?
    
    func fetchVideos() {
        
        
        ApiService.sharedInstance.fetchVideos { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
            self.collectionView.collectionViewLayout.invalidateLayout()
            
        }
        
    }
    
    override func setupviews(){
        
         super.setupviews()
        
       fetchVideos()
        

        
        addSubview(collectionView)
        
        
        
//        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            
//            flowLayout.scrollDirection = .vertical
//            
//    
//        }
    
    
        collectionView.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        collectionView.register(cell.self, forCellWithReuseIdentifier: cellid)

    }
    
    
    

         func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return videos?.count ?? 0
        }
    
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! cell
    
    
            cell.video = videos?[indexPath.item]
                        
            return cell
        }
    
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
    
            let height = (frame.width - 16 - 16) * 9 / 16
            return CGSize(width: frame.width, height: height + 16 + 68)
        }
    
    
//    func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//        return true
//    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//               let selectedVideo = self.videos?[indexPath.item]
//               let layout = UICollectionViewFlowLayout()
//                let videoDetailedViewController = VideoDetailedController(collectionViewLayout: layout)
//                videoDetailedViewController.video = selectedVideo
//
//
//             let navController = UINavigationController(rootViewController: videoDetailedViewController)
//
//            present(navController, animated: true, completion: nil)
        
        let videoLauncher = VideoDetailedController()
        
        videoLauncher.showVideoPlayer()



        
            
    
    
    }
    
 
    

}
