//
//  MenuBar.swift
//  YouTubeSample
//
//  Created by Mohammad Farhoudi on 08/12/2017.
//  Copyright © 2017 Mohammad Farhoudi. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        cv.dataSource = self
        cv.delegate = self
        return cv
        
    }()
    
    let ImageNames = ["home", "trending", "subscriptions", "account"]
    
    
    var homeController:  ViewController?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
         collectionView.register(MenuCell.self, forCellWithReuseIdentifier: "MenuCellid")
        
        
        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
        
        collectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: .bottom)
        
       addSubview(collectionView)
        
        collectionView.widthAnchor.constraint(equalToConstant: 380).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        
        setupHorizontalBar()

        
    }
    
    
    var horizontalBarLeftAnchorConstraint : NSLayoutConstraint?
    
    func setupHorizontalBar() {
    
    let horizontalBarView = UIView()
    horizontalBarView.backgroundColor = UIColor(white: 0.9, alpha: 1)
    horizontalBarView.translatesAutoresizingMaskIntoConstraints = false

    addSubview(horizontalBarView)
        
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let x = CGFloat(indexPath.item) * frame.width / 4
//        self.horizontalBarLeftAnchorConstraint?.constant = x
//        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.layoutIfNeeded()
//        }, completion: nil)
        
        
        homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCellid", for: indexPath) as! MenuCell

        cell.imageView.image = UIImage(named: ImageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.init(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    class MenuCell: BaseCell {
        
        let imageView: UIImageView = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.image = UIImage(named:"home")?.withRenderingMode(.alwaysOriginal)
            image.tintColor = UIColor.init(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
            return image
        }()
        
        
        
        override var isHighlighted: Bool {

            didSet{
//                TERNARY OPERATOR
                imageView.tintColor = isHighlighted ? UIColor.white : UIColor.init(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
                
            }
        }
        
        
        override var isSelected: Bool{
            
            didSet{
    
                imageView.tintColor = isSelected ? UIColor.white : UIColor.init(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
                
            }
        }
        
        
        override func setupviews() {
            super.setupviews()
            
            addSubview(imageView)
            imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
//            imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
            backgroundColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        }
    
}
}
