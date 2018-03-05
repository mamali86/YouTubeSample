//
//  SettingLauncher.swift
//  YouTubeSample
//
//  Created by Mohammad Farhoudi on 19/12/2017.
//  Copyright © 2017 Mohammad Farhoudi. All rights reserved.
//

import UIKit



enum SettingName: String {
    case Cancel = "Cancel annd dismiss"
    case Setting = "Settings"
    case TermsPrivacy = "Terms and privacy policy"
    case Feedback = "Send Feedback"
    case Help = "Help"
    case SwitchAccount = "Switch Account"
}


class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    let blackView = UIView()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white

        return cv
    }()
    
    
    
    
    let settings: [Setting] = {
        
        
    let cancelSetting = Setting(title: .Cancel, image: #imageLiteral(resourceName: "cancel"))
    let settingsSetting = Setting(title: .Setting, image: #imageLiteral(resourceName: "settings"))
        
    return[ settingsSetting,
    Setting(title: .TermsPrivacy, image:#imageLiteral(resourceName: "privacy")),
    Setting(title: .Feedback, image: #imageLiteral(resourceName: "feedback")),
    Setting(title: .Help, image: #imageLiteral(resourceName: "help")),
    Setting(title: .SwitchAccount, image: #imageLiteral(resourceName: "switch_account")),
        cancelSetting] }()
    
    
    @objc func showSettings() {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(handleDismiss)))
            window.addSubview(blackView)
            window.addSubview(collectionView)
            blackView.frame = window.frame
            let height:CGFloat = 300
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            blackView.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellSetting", for: indexPath) as! settingsSliding
        
        let setting = settings[indexPath.item]
        
        cell.setting = setting

        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0 
    }
    
    var homeController: ViewController?

    
    @objc func handleDismiss(setting: Setting) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
            
        }) { (completed: Bool) in
            
            
            if  setting.title != .Cancel {
                self.homeController?.showControllerForSetting(setting: setting)
            }
            
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let setting = self.settings[indexPath.item]
        handleDismiss(setting: setting)

    
    }

    
    
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(settingsSliding.self, forCellWithReuseIdentifier: "cellSetting")
    }
}
