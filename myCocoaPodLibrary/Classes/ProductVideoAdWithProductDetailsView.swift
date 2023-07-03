//
//  ProductAdView.swift
//  Pods
//
//  Created by Abhishek.Batra on 6/27/23.
//

import UIKit
import AVKit

public class ProductVideoAdWithProductDetailsView: UIView {

    
        @IBOutlet weak var containerView: UIView!
    static let kCONTENT_XIB_NAME = "ProductVideoAdWithProductDetailsView"
    @IBOutlet var productVideoView: UIView!
    @IBOutlet var productDetailView: UIView!
//    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var lblProductTitle: UILabel!
    @IBOutlet var lblProductPrice: UILabel!
    
    private let player = AVPlayer()
    private let playerViewController = AVPlayerViewController()
    private var mediadetails:ProductMediaDetail?

    
    open var loaded: ((Bool, CGFloat)->())!
    open var advertisementTapped: ((String)->())?
    
    private var videoLoaded:Bool = false
    /// Ads video url: Property
    var productAdVideoUrl: String?{
        didSet {
            loadAdsUrl()
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
//        getVideoHeight()
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        initCode();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCode();
    }
    
    
    class public func instanceFromNib(producttitle:String) -> UIView {
        let view: ProductVideoAdWithProductDetailsView = ProductVideoAdWithProductDetailsView.initFromNib()
        view.lblProductTitle.text = producttitle
        return view
        
    }

    @IBAction func adTapped(_ sender: Any) {
        if let advTapped = advertisementTapped {
            //TODO: Update ProductID
            advTapped("12")
        }
    }
    
}



extension ProductVideoAdWithProductDetailsView {
    
    static func initFromNib<T: UIView>() -> T {
        let bundle = Bundle(for: ProductVideoAdWithProductDetailsView.self)
        let nib = UINib(nibName: "ProductVideoAdWithProductDetailsView", bundle: bundle)
        return nib.instantiate(withOwner: nil)[0] as! T
    }
        func initCode() {
        NotificationCenter.default.addObserver(self,
               selector: #selector(playerItemDidReadyToPlay(notification:)),
               name: .AVPlayerItemNewAccessLogEntry,
                                               object: player.currentItem)
            ServiceManager.shared.getProductAd { productAdResp in
                if productAdResp.data.adsData?.count ?? 0>0 && productAdResp.data.adsData?[0].ads?.count ?? 0>0 && productAdResp.data.adsData?[0].ads?[0].mediaDetails?.count ?? 0>0 {
                    if let videoURL = productAdResp.data.adsData?[0].ads?[0].mediaDetails?[0].mediaAccessURL, let mediadetails = productAdResp.data.adsData?[0].ads?[0].mediaDetails?[0]  {
                        self.productAdVideoUrl = videoURL
                        self.mediadetails = mediadetails
                        ServiceManager.shared.getProductDetails(clientId: "70891516", productSku: "6107B330168080") { productDetailResp in
                            DispatchQueue.main.async {
//                                self.productImageView.image = UIImage(data: try! Data(contentsOf: URL(string: productDetailResp.products[0].imageUrls[0])!))
                                self.lblProductTitle.text = productDetailResp.products[0].title
                                self.lblProductPrice.text = productDetailResp.products[0].price.currency + " " + "\(productDetailResp.products[0].price.amount)"
                                self.loaded(true, self.getVideoHeight())
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
                if !videoLoaded {
                    videoLoaded = true
                    loaded(true, getVideoHeight())
                }
            }
    }
    
    func getVideoHeight() -> CGFloat {
        let aspectRatio = mediadetails?.aspectRatio.components(separatedBy: ":")
        if aspectRatio?.count ?? 0 == 2 {
            
            if let widthRatio = NumberFormatter().number(from: aspectRatio?[0] ?? "0"), let heightRatio = NumberFormatter().number(from: aspectRatio?[1] ?? "0") {
                let wRatio = CGFloat(truncating: widthRatio)
                let hRatio = CGFloat(truncating: heightRatio)
                return productVideoView.frame.size.width * hRatio / wRatio
                
            } else{
                return productVideoView.frame.size.width * 9 / 16
            }
        } else {
            return productVideoView.frame.size.width * 9 / 16
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
            let playerItem = AVPlayerItem(url: videoURL)
            print("playerItem", playerItem)
            player.replaceCurrentItem(with: playerItem)
            player.isMuted = true
            playerViewController.player = player
            playerViewController.showsPlaybackControls = false
            
            DispatchQueue.main.async { [self] in
                productVideoView.addSubview(self.playerViewController.view)
                let lblAd = Utils.getAdLabel()
                self.addSubview(lblAd)
                self.bringSubviewToFront(lblAd)
                self.playerViewController.view.frame = productVideoView.bounds
                self.playerViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            }
            self.player.play()
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(self.playerItemDidReachEnd(notification:)),
                                                   name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                   object: self.player.currentItem)
        }
        
    }
    
    // A notification is fired and seeker is sent to the beginning to loop the video again
    @objc func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: CMTime.zero) { (isFinished:Bool) -> Void in
            self.player.play()
        }
    }
   
}
