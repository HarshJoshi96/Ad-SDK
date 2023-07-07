//
//  AdsView.swift
//  myCocoaPodLibrary
//
//  Created by Abhishek.Batra on 6/26/23.
//

import Foundation
import UIKit
import AVKit

public class ProductVideoDetailsHorizontalAd: UIView {
    
    private let player = AVPlayer()
    private let playerViewController = AVPlayerViewController()
    private var playerItem: AVPlayerItem?
    private var pausedTime: Double = 0.0
    private var mediadetails:ProductMediaDetail?
    private var adViewHeight: CGFloat = 0 {
        didSet {
            self.udpateFrame()
        }
    }
    private var productAdResponse: ProductAdResponse?
    private var touchHandlerButton = UIButton()
    var observer: NSKeyValueObservation?
    private var videoLoaded:Bool = false
    private var productVideoView = UIView()
    private var productDetailView = UIView()
    private var lblProductTitle = UILabel()
    private var lblProductPrice = UILabel()
    let productVideoWidthRatio: CGFloat = 0.40
    let productDetailWidthRatio: CGFloat = 1 - 0.40


    
    /// Ads video url: Property
    var productAdVideoUrl: String?{
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
        getVideoHeightAndUpdateVideoFrame()
    }
    
    func initCode() {
        renderUIForView()
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        NotificationCenter.default.addObserver(self,
               selector: #selector(playerItemDidReadyToPlay(notification:)),
               name: .AVPlayerItemNewAccessLogEntry,
                                               object: player.currentItem)
        ServiceManager.shared.getProductAd { productAdResp in
            self.productAdResponse = productAdResp
            if productAdResp.data.adsData?.count ?? 0>0 && productAdResp.data.adsData?[0].ads?.count ?? 0>0 && productAdResp.data.adsData?[0].ads?[0].mediaDetails?.count ?? 0>0 {
                if let videoURL = productAdResp.data.adsData?[0].ads?[0].mediaDetails?[0].mediaAccessURL, let mediadetails = productAdResp.data.adsData?[0].ads?[0].mediaDetails?[0]  {
                    self.productAdVideoUrl = videoURL
                    self.mediadetails = mediadetails
                    ServiceManager.shared.getProductDetails(clientId: "70891516", productSku: "6107B330168080") { productDetailResp in
                        DispatchQueue.main.async {
//                                self.productImageView.image = UIImage(data: try! Data(contentsOf: URL(string: productDetailResp.products[0].imageUrls[0])!))
                            self.lblProductTitle.text = productDetailResp.products[0].title
                            self.lblProductPrice.text = productDetailResp.products[0].price.currency + " " + "\(productDetailResp.products[0].price.amount)"
                            if let playerAdItem = self.playerItem, playerAdItem.status == .readyToPlay {
                                self.loaded(true, self.adViewHeight)
                            }
                        }
                    }
                }
            } else {
                self.loaded(false, 0)
            }
        }
    }
    


    @objc func playerItemDidReadyToPlay(notification: Notification) {
            if let _ = notification.object as? AVPlayerItem {
                // player is ready to play now!!
//                loaded(true, adViewHeight)
            }
    }
    
    
    @objc func adTapped() {
        if let advTapped = advertisementTapped {
            //TODO: pass product Id
            if let prodResp = productAdResponse, prodResp.data.adsData?.count ?? 0>0 && prodResp.data.adsData?[0].ads?.count ?? 0>0 && prodResp.data.adsData?[0].ads?[0].skus?.count ?? 0 > 0 {
                advTapped((prodResp.data.adsData?[0].ads?[0].skus?[0].id)!)
            }
        }
    }
    
    func udpateFrame() {
        let videoViewWidth = self.frame.width * productVideoWidthRatio
        self.productVideoView.frame = CGRect(x: 0, y: 0, width: videoViewWidth, height: self.adViewHeight)
        self.productDetailView.frame = CGRect(x: productVideoView.frame.maxX, y: 0, width: productDetailView.frame.width, height: adViewHeight)

    }
    
    func getVideoHeightAndUpdateVideoFrame() {
        let videoViewWidth = self.frame.width * productVideoWidthRatio
        let aspectRatio = self.mediadetails?.aspectRatio.components(separatedBy: ":")
        if aspectRatio?.count ?? 0 == 2 {
            if let widthRatio = NumberFormatter().number(from: aspectRatio?[0] ?? "0"), let heightRatio = NumberFormatter().number(from: aspectRatio?[1] ?? "0") {
                let wRatio = CGFloat(truncating: widthRatio)
                let hRatio = CGFloat(truncating: heightRatio)
                self.adViewHeight = videoViewWidth * hRatio / wRatio
                print(self.adViewHeight);
            } else{
                self.adViewHeight = 0
            }
        } else {
            self.adViewHeight = 0
        }
    }
    
    //MARK: This will load video ads url
    public func loadAdsUrl() {
        if let videoURL = productAdVideoUrl {
            guard let videoURL = URL(string: videoURL) else {
                // Handle invalid URL
                print("Please check your url", videoURL)
                return
            }
            print("Video url is okay", videoURL)
            playerItem = AVPlayerItem(url: videoURL)
            player.replaceCurrentItem(with: playerItem)
            player.isMuted = true
            playerViewController.player = player
            playerViewController.showsPlaybackControls = false
            
            DispatchQueue.main.async { [self] in
                productVideoView.addSubview(self.playerViewController.view)
                let lblAd = Utils.getAdLabel()
                self.addSubview(lblAd)
                self.bringSubviewToFront(lblAd)
                self.getVideoHeightAndUpdateVideoFrame()
                self.playerViewController.view.frame = productVideoView.bounds
                self.playerViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            }
            self.player.play()

   
                // Register as an observer of the player item's status property
            self.observer = self.playerItem!.observe(\.status, options:  [.new, .old], changeHandler: { (playerItem, change) in
                if let playerAdItem = self.playerItem, playerAdItem.status == .readyToPlay {
                        print("Ready to play ====++++")
                        if !self.videoLoaded && self.adViewHeight > 0 {
                            self.videoLoaded = true
                            self.loaded(true, self.adViewHeight)
                        }
                    }
                })
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(self.playerItemDidReachEnd(notification:)),
                                                   name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                   object: self.player.currentItem)
        }
        
    }
    
    
    func renderUIForView() {
        let productDetailViewWidth = self.frame.width * productDetailWidthRatio
        let lblH_Padding : CGFloat = 8
        let lblV_Padding : CGFloat = 8
        
        getVideoHeightAndUpdateVideoFrame()
        self.addSubview(productVideoView)
        
        productDetailView.frame = CGRect(x: productVideoView.frame.maxX, y: 0, width: productDetailViewWidth, height: adViewHeight)
        self.addSubview(productDetailView)
        
        lblProductTitle.frame = CGRect(x: lblH_Padding, y: lblV_Padding, width: productDetailView.frame.width - (lblH_Padding*2), height: 35)
        lblProductTitle.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        lblProductTitle.numberOfLines = 2
        productDetailView.addSubview(lblProductTitle)

        lblProductPrice.frame = CGRect(x: lblH_Padding, y: lblProductTitle.frame.maxY + lblV_Padding, width: productDetailView.frame.width - (lblH_Padding*2), height: 20)
        lblProductPrice.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lblProductPrice.numberOfLines = 1
        productDetailView.addSubview(lblProductPrice)
        
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

}
