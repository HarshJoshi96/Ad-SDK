//
//  AdsView.swift
//  myCocoaPodLibrary
//
//  Created by Abhishek.Batra on 6/26/23.
//

import Foundation
import UIKit
import AVKit


public class BrandAdView: UIView, UIWebViewDelegate {
    
    private var player = AVPlayer()
    private let playerViewController = AVPlayerViewController()
    private var pausedTime: Double = 0.0
    private var mediadetails:MediaDetail?
    private var adViewHeight: CGFloat = 0
    private var brandResponse: BrandAdResponse?
    private var touchHandlerButton = UIButton()
    var observer: NSKeyValueObservation?

    
    /// Ads video url: Property
    var adsVideoUrl: String?{
        didSet {
            loadAdsUrl()
        }
    }
    
    open var loaded: ((Bool, CGFloat)->())!
    open var advertisementTapped: ((String)->())?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initCode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCode()
    }
    
    public override func layoutSubviews() {
        touchHandlerButton.frame = self.bounds
        getVideoViewHeight()
    }
    
    func initCode() {
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        ServiceManager.shared.getBrandAd { brandAd in
            self.brandResponse = brandAd
            if brandAd.data.ads.count>0 && brandAd.data.ads[0].mediaDetails.count>0 {
                self.adsVideoUrl = brandAd.data.ads[0].mediaDetails[0].mediaAccessURL
                self.mediadetails = brandAd.data.ads[0].mediaDetails[0]
            }

        }
    }
    
   
    
    
    @objc func adTapped() {
        if let advTapped = advertisementTapped {
            //TODO: pass brand Id
            advTapped("1")
        }
    }
    
    func getVideoViewHeight() {
        let aspectRatio = mediadetails?.aspectRatio.components(separatedBy: ":")
        if aspectRatio?.count ?? 0 == 2 {
            
            if let widthRatio = NumberFormatter().number(from: aspectRatio?[0] ?? "0"), let heightRatio = NumberFormatter().number(from: aspectRatio?[1] ?? "0") {
                let wRatio = CGFloat(truncating: widthRatio)
                let hRatio = CGFloat(truncating: heightRatio)
                self.adViewHeight = self.frame.width * hRatio / wRatio
                
            } else{
                self.adViewHeight = 0
            }
        } else {
            self.adViewHeight =  0
        }
    }
    
    //MARK: This will load video ads url
    public func loadAdsUrl() {
        if let videoURL = adsVideoUrl {
            guard let videoURL = URL(string: videoURL) else {
                // Handle invalid URL
                print("Please check your url", videoURL)
                return
            }
            print("Video url is okay", adsVideoUrl ?? "")
            let playerItem = AVPlayerItem(url: videoURL)
            print("playerItem", playerItem)
            player.replaceCurrentItem(with: playerItem)
            player.isMuted = true
            playerViewController.player = player
            playerViewController.showsPlaybackControls = false
            
            DispatchQueue.main.async { [self] in
                self.addSubview(self.playerViewController.view)
                let lblAd = Utils.getAdLabel()
                self.addSubview(lblAd)
                self.bringSubviewToFront(lblAd)
                self.addTapHandler()
                self.playerViewController.view.frame = self.bounds
                self.playerViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                getVideoViewHeight()
                
            }
            
            self.player.play()
            // Register as an observer of the player item's status property
            self.observer = playerItem.observe(\.status, options:  [.new, .old], changeHandler: { (playerItem, change) in
                if playerItem.status == .readyToPlay {
                    print("Ready to play ====++++")
//                    if !self.videoLoaded {
//                        self.videoLoaded = true
                    self.getVideoViewHeight()
                        self.loaded(true, self.adViewHeight)
//                    }
                }
            })
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(self.playerItemDidReachEnd(notification:)),
                                                   name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                   object: self.player.currentItem)
            
            NotificationCenter.default.addObserver(self, selector: #selector(setPlayerLayerToNil), name: UIApplication.didEnterBackgroundNotification, object: nil)

                // foreground event
                NotificationCenter.default.addObserver(self, selector: #selector(reinitializePlayerLayer), name: UIApplication.willEnterForegroundNotification, object: nil)

               // add these 2 notifications to prevent freeze on long Home button press and back
                NotificationCenter.default.addObserver(self, selector: #selector(setPlayerLayerToNil), name: UIApplication.willResignActiveNotification, object: nil)

                NotificationCenter.default.addObserver(self, selector: #selector(reinitializePlayerLayer), name: UIApplication.didBecomeActiveNotification, object: nil)

            NotificationCenter.default.addObserver(self,
                   selector: #selector(playerItemDidReadyToPlay(notification:)),
                   name: .AVPlayerItemNewAccessLogEntry,
                                                   object: player.currentItem)
        }
        
    }
    
    func addTapHandler() {
        touchHandlerButton = UIButton(type: .custom)
        touchHandlerButton.frame = self.bounds
        touchHandlerButton.addTarget(self, action: #selector(adTapped), for: .touchUpInside)
        self.addSubview(touchHandlerButton)
    }
    

    // A notification is fired and seeker is sent to the beginning to loop the video again
    @objc func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        
        p.seek(to: CMTime.zero) { (isFinished:Bool) -> Void in
//            self.pausedTime = 0.0
            self.player.play()
        }
    }
    @objc fileprivate func setPlayerLayerToNil(){
        // first pause the player before setting the playerLayer to nil. The pause works similar to a stop button
        player.pause()
    }

     // foreground event
    @objc fileprivate func reinitializePlayerLayer(){

//      if player != nil{
            if #available(iOS 10.0, *) {
                if player.timeControlStatus == .paused{
                    player.play()
                }
            } else {
                // if app is running on iOS 9 or lower
                if player.isPlaying == false{
                    player.play()
                }
            }
//        }
    }


    @objc func playerItemDidReadyToPlay(notification: Notification) {
            if let _ = notification.object as? AVPlayerItem {
                // player is ready to play now!!
//                loaded(true, adViewHeight)
            }
    }
    

    public func pausePlayer() {
        // AVPlayer Paused Time is a global value of type Double
        self.pausedTime = Double(CMTimeGetSeconds(self.player.currentTime()))
        print("AVPlayer Paused Time: ", self.pausedTime)
        self.player.pause()
    }
    
    public func resumePlayer() {
        print("AVPlayer Paused Time: ", self.pausedTime)
        self.player.seek(to: CMTimeMakeWithSeconds(self.pausedTime, preferredTimescale: 1))
        self.player.play()
    }
}
