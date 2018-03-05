//
//  cell.swift
//  YouTubeSample
//
//  Created by Mohammad Farhoudi on 28/11/2017.
//  Copyright © 2017 Mohammad Farhoudi. All rights reserved.
//




import UIKit
import Foundation


class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setupviews()
    }
    
    func setupviews(){
      
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class cell: BaseCell {
    
    
    var video: Video? {
        
        didSet{
            titleLabel.text = video?.title
            

            guard let thumbnail_image_name_original = video?.thumbnail_image_name else {return}
            
            Mainimage.loadImageUsingUrlString(urlString: thumbnail_image_name_original)

            guard let profile_image_name_url = video?.channel?.profile_image_name else {return}
            imageView.loadImageUsingUrlString(urlString: profile_image_name_url)

            if let channelName = video?.channel?.name, let numberofViews = video?.number_of_views {
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                let subtitleText = "\(channelName) • \(numberFormatter.string(from: numberofViews)!) • 2 years ago"
                subtitleTextView.text = subtitleText
            }
            
            
            if let title = video?.title {
                
                let size  = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)], context: nil)
                
                
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 22
                }
                
                
            }
        
            

        }
    }
    
    
    let Mainimage: CustomImageView = {
        let image = CustomImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "taylor_swift_blank_space")
        return image
    }()
    
    let imageView: CustomImageView = {
        let image = CustomImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "taylor_swift_profile")
        image.layer.cornerRadius = 22
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let separatorline: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
        
    }()
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        label.text = "Taylor Swift - Blank Space"
        
        return label
    }()
    
    
    
    
    let subtitleTextView: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "Taylor Swift • 2,604,876 views • 2 years ago"
        text.textColor = UIColor.lightGray
        text.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        text.font = UIFont.boldSystemFont(ofSize: 11)
        
        return text
    }()
    
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    
    override func setupviews() {
     
        
        addSubview(Mainimage)
        
        Mainimage.widthAnchor.constraint(equalToConstant: 340).isActive = true
        Mainimage.heightAnchor.constraint(equalToConstant: 180).isActive = true
        Mainimage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        Mainimage.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: Mainimage.bottomAnchor, constant: 5).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.leftAnchor.constraint(equalTo: Mainimage.leftAnchor, constant: 0).isActive = true
        
        
        addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 4).isActive = true
        titleLabelHeightConstraint = titleLabel.heightAnchor.constraint(equalToConstant: 44)
        addConstraint(titleLabelHeightConstraint!)
        titleLabel.widthAnchor.constraint(equalToConstant: 306).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 0).isActive = true
        
        
        
        addSubview(subtitleTextView)
        subtitleTextView.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 2).isActive = true
        subtitleTextView.widthAnchor.constraint(equalToConstant: 306).isActive = true
        subtitleTextView.heightAnchor.constraint(equalToConstant: 34).isActive = true
        subtitleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        
        addSubview(separatorline)
        
        separatorline.widthAnchor.constraint(equalToConstant: 360).isActive = true
        separatorline.heightAnchor.constraint(equalToConstant: 2).isActive = true
        separatorline.topAnchor.constraint(equalTo: subtitleTextView.bottomAnchor, constant: 14).isActive = true
        
    }
    
    
    
    
}
