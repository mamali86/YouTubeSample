//
//  ViewController.swift
//  YouTubeSample
//
//  Created by Mohammad Farhoudi on 27/11/2017.
//  Copyright © 2017 Mohammad Farhoudi. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {


    let mainCellId = "mainCellId"
    let trendingCellId = "trendingCellId"
    let subscriptionCellId = "subscriptionCellId"
    
     let titles = ["Home", "Trending", "Subscriptions", "Account"]
    
     var videos: [Video]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        collectionView?.backgroundColor = .white
        
        navigationController?.navigationBar.isTranslucent = false


        setupCollectionView()
        setupNavigationBarItems()
        setupMenuBar()
        
    }
    
    
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
    }()
    
    
    
    
    func setupCollectionView() {
        
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
            
        }
        
        

        
        
        collectionView?.register(menuCell.self, forCellWithReuseIdentifier: mainCellId)
        
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        
         collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionCellId)
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.isPagingEnabled = true
    
        
    }
    
    
    private func setupMenuBar() {
        
        navigationController?.hidesBarsOnSwipe = true
        
        
        view.addSubview(menuBar)
        
        menuBar.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        menuBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        let identifier: String
        if indexPath.item == 1 {
            identifier = trendingCellId
        }  else if indexPath.item == 2 {
            identifier = subscriptionCellId
            
        } else {
            identifier = mainCellId
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
                
//        let colours: [UIColor] = [.red, .blue, .purple, .white]
//        cell.backgroundColor = colours[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    
    }
    
    
    func setupNavigationBarItems() {
        setupLeftNavItem()
        setupRightNavItems()
    }
    
    
     func setupLeftNavItem() {

        
        if let navigationBar = self.navigationController?.navigationBar {
        
                        let label = UILabel()
                        label.translatesAutoresizingMaskIntoConstraints = false
                        label.numberOfLines = 1
                        label.font = UIFont.boldSystemFont(ofSize: 16)
                        label.text = "Home"
                        label.textColor = .white
                        navigationBar.addSubview(label)
                        navigationItem.titleView = label
            
            
            
            label.widthAnchor.constraint(equalToConstant: 120).isActive = true
            label.heightAnchor.constraint(equalToConstant: 60).isActive = true
            label.leftAnchor.constraint(equalTo: navigationBar.leftAnchor, constant: 15).isActive = true

        
        }
        
        
    }
    
    
    
    func setTitlesForIndex(index: Int) {
        
        
//        if let homeButton = navigationItem.titleView as? UIButton {
//
//            homeButton.titleLabel?.text = "  \(titles[index])"
//        }
        
        if let label = navigationItem.titleView as? UILabel {
            
            label.text = "  \(titles[index])"
            
        }
        
        
        
    }
    
    
    private func setupRightNavItems() {
        
        let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search_icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
        
        let composeButton = UIBarButtonItem(image: #imageLiteral(resourceName: "nav_more_icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [composeButton, searchButton]
    }
    
    
    
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        
        let Index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = NSIndexPath(item: Int(Index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: .bottom)
        
        setTitlesForIndex(index: Int(Index))
    
    
    }
    

    @objc func handleSearch() {

    scrollToMenuIndex(menuIndex: 2)
    
    }
    
    
    func scrollToMenuIndex(menuIndex: Int) {
        
        let IndexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: IndexPath as IndexPath, at: .right, animated: true)
        setTitlesForIndex(index: menuIndex)
            }
    
    
    // if settingsLauncher != nil anymore, the code inside will get called only once
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    
    @objc func handleMore() {
        
//        settingsLauncher.homeController = self
        
        settingsLauncher.showSettings()
        
    }
    
    public func showControllerForSetting(setting: Setting) {
        let dummyViewController = UIViewController()
        navigationController?.pushViewController(dummyViewController, animated: true)
        dummyViewController.view.backgroundColor = .white
        dummyViewController.navigationItem.title = setting.title.rawValue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationItem.title = "Home"
    
        
    }
    
    


    }
    


