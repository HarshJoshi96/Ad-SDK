//
//  SelectAdView.swift
//  inmobi-ios-adSDK
//
//  Created by Harsh.Joshi on 06/07/23.
//

import Foundation
import AVFoundation
public class SelectAdOption: NSObject {
    private var ads1View: BrandAdView!
    var width: Int!
    var vframe: CGRect!
    var typeAd:String!
    private var player = AVPlayer()
    open var videoLoaded: ((UIView, Bool, CGFloat)->())!
    open var itemAdvertisementTapped: ((String)->())!
    public init(frame: CGRect,width: Int,typeAd: String){
        self.vframe = frame
        self.width = width
        self.typeAd = typeAd
        super.init()
        self.setupPlayer()
        print(AdTypes.brandAd.rawValue, typeAd)
        if typeAd ==  AdTypes.brandAd.rawValue {
//            setupAd1View(viewWidth: width)
        }else if typeAd ==  AdTypes.horizontalTextAd.rawValue {
//            setupAd2View(viewWidth: width)
        }
        else{
            //setupAd2View(viewWidth: width)
        }
        
    }
    
    //        required init?(coder aDecoder: NSCoder) {
    //            super.init(coder: aDecoder)
    //            if typeAd == "brand" {
    //                setupAd1View(viewWidth: width)
    //            }else{
    //                setupAd2View(viewWidth: width)
    //            }
    //        }
    
   private func setupPlayer() {
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
    
//    func setupAd1View(viewWidth:Int) {
//        self.ads1View = BrandAdView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: 0), videoItem:self.player)
//
//        self.ads1View.isHidden = true
//        self.ads1View.loaded = { isLoaded, viewHeight in
//            self.ads1View.isHidden = !isLoaded
//            DispatchQueue.main.async {
//                if isLoaded && self.ads1View.frame.size.height != viewHeight {
//                    self.ads1View.frame = CGRect(x: 0, y: 0, width: viewWidth, height: Int(viewHeight))
////                    self.ads1View.layoutIfNeeded()
//                    self.videoLoaded(self.ads1View, true, viewHeight)
//                } else {
//                    if !isLoaded {
//                        self.videoLoaded(self.ads1View, false, 0)
//                    }
//                }
//            }
//        }
//        self.ads1View.advertisementTapped = {productDetails in
//            self.itemAdvertisementTapped(productDetails)
//        }
//    }
    
//    func setupAd2View(viewWidth:Int) {
//        let productAd = ProductVideoDetailsHorizontalAd(frame: CGRect(x: 0, y: 0, width: viewWidth, height: 0),videoItem: player)
//        DispatchQueue.main.async { [self] in
//            productAd.isHidden = true
//            productAd.loaded = { isLoaded, viewHeight in
//                productAd.isHidden = !isLoaded
//                if isLoaded && productAd.frame.size.height != viewHeight {
//                    productAd.frame = CGRect(x: 0, y: 0, width: viewWidth, height: Int(viewHeight))
//                    self.videoLoaded(productAd, true, viewHeight)
//                    print("in setup view")
//                } else {
//                    if !isLoaded {
//                        productAd.frame = CGRect(x: 0, y: 0, width: viewWidth, height: 0)
//                    }
//                }
//            }
//        }
//        productAd.advertisementTapped = { productSKU in
//            self.itemAdvertisementTapped(productSKU as String)
//            print("Video tapped for Product SKU", productSKU)
//        }
//    }
}
