//
//  VideoDetailedController.swift
//  YouTubeSample
//
//  Created by Mohammad Farhoudi on 08/02/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation



class VideoPlayerView: UIView {
    
      var player: AVPlayer?
    
    
    let startTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
        
    }()
    
    
    
    
    
    let videoSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
        
    }()
    
    
    @objc func handleSliderChange() {
        
        
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(videoSlider.value) * totalSeconds
            let seektime = CMTimeMake(Int64(value), 1)

        player?.seek(to: seektime, completionHandler: { (completedSeek) in
            
            
        })
            
               }
        
        
        
        
    }
    
    let fullTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
        
    }()
    
    
    let pausePlayButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "pause")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        return button
    }()
    
    
    var isPlaying = false
    
    
    @objc func showButton() {
        pausePlayButton.isHidden = true
        
    }
    
    @objc func handlePause () {
        if isPlaying {
        player?.pause()
        pausePlayButton.setImage(UIImage(named: "play"), for: .normal)
       
        }
        else {
            player?.play()
             pausePlayButton.setImage(UIImage(named: "pause"), for: .normal)
            pausePlayButton.isHidden = true
            
        }
        
        isPlaying = !isPlaying
        
    }
    
    
    
    let darkVideoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let av = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        av.translatesAutoresizingMaskIntoConstraints = false
        av.startAnimating()
        return av
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setupGradientLayer()
        
        setupPlayerView()
         backgroundColor = .black
        
        darkVideoView.frame = frame
       
        addSubview(darkVideoView)
        let tapRecogniser = UITapGestureRecognizer(target: self, action:  #selector(handlePause))
        
        
        darkVideoView.addGestureRecognizer(tapRecogniser)
        tapRecogniser.numberOfTapsRequired = 1
        darkVideoView.isUserInteractionEnabled = true
        
        
        addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        pausePlayButton.isHidden = true
        
        
        darkVideoView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        activityIndicatorView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        activityIndicatorView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        addSubview(startTimeLabel)
        startTimeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        startTimeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        startTimeLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        startTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        addSubview(fullTimeLabel)
        fullTimeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        fullTimeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 1).isActive = true
        fullTimeLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        fullTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        addSubview(videoSlider)
        videoSlider.rightAnchor.constraint(equalTo: fullTimeLabel.leftAnchor, constant: -10).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        videoSlider.leftAnchor.constraint(equalTo: startTimeLabel.rightAnchor, constant: 0).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        
    }
    
    
    private func setupPlayerView () {
    
    let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
    
    if let URL = URL(string: urlString) {
        
        player = AVPlayer(url: URL as URL)
        
        let playerLayer = AVPlayerLayer(player: player)
        self.layer.addSublayer(playerLayer)
        playerLayer.frame = self.frame
        
        player?.play()
        player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        let interval = CMTime(value: 1, timescale: 2)
        player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
            
            let trackingSeconds = CMTimeGetSeconds(progressTime)
            let startSeconds = String(format: "%02d", Int(trackingSeconds.truncatingRemainder(dividingBy: 60)))
            let minutesText = String(format: "%02d", Int(trackingSeconds) / 60)
            self.startTimeLabel.text = "\(minutesText):\(startSeconds)"
            
            if let duration = self.player?.currentItem?.duration {
            let TSeconds = CMTimeGetSeconds(duration)
                
                
                 self.videoSlider.value = Float(trackingSeconds / TSeconds)
                
            }
        })
    }
    }
    
  
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            

            activityIndicatorView.stopAnimating()
            
            
            pausePlayButton.isHidden = false
            darkVideoView.backgroundColor = .clear
            isPlaying = true
            
            if let duration = player?.currentItem?.duration {
            let seconds = CMTimeGetSeconds(duration)
            let secondsText = Int(seconds.truncatingRemainder(dividingBy: 60))
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                fullTimeLabel.text = "\(minutesText):\(secondsText)"
            }
            
    
        }

    }
    
    
    private func setupGradientLayer() {
    
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.2]
        darkVideoView.layer.addSublayer(gradientLayer)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}

class VideoDetailedController: NSObject {
    
    var video: Video?
    
    func showVideoPlayer() {
        
        if let keyWindow = UIApplication.shared.keyWindow {
            
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = .white
            

    
            
            
            view.frame = CGRect(x: keyWindow.frame.width - 10 , y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: keyWindow.frame.width * 9 / 16)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            
            
            view.addSubview(videoPlayerView)
            
            keyWindow.addSubview(view)
            
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                view.frame = keyWindow.frame
                
             
                
                
            }) { (completed: Bool) in
                
//                UIApplication.shared.setStatusBarHidden(true, with: .Fade)
                
            }
            
        }
    
    }
    
    
    

    
    
}
