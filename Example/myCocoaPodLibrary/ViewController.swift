//
//  ViewController.swift
//  inmobi-ios-adSDK
//
//  Created by 135563768 on 06/30/2023.
//  Copyright (c) 2023 135563768. All rights reserved.
//

import UIKit
import myCocoaPodLibrary

class ViewController: UIViewController {
    
//    private var adsFramework3: TopVideoWithBottomProductDetails!
//    private var adsFramework2: ProductVideoAdWithProductDetailsView!
//    private var adsFramework1: BrandAdView!
    
    @IBOutlet weak var scrollViewContainer: UIView!
    @IBOutlet weak var ads1View: UIView!
    @IBOutlet weak var ad1HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var ads2View: UIView!
    @IBOutlet weak var ad2HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var ads3View: UIView!
    @IBOutlet weak var ad3HeightConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Logger().printLog()
        setupAd1View()
        setupAd2View()
        setupAd3View()
//        setupAd4View()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    func setupAdView() {
    //
    //        // MARK: - Initialization Framework
    //        self.adsFramework1 = AdsView(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: 0))
    //
    ////        self.adsFramework = (ProductVideoAdWithProductDetailsView.instanceFromNib(producttitle: "Product 1") as! ProductVideoAdWithProductDetailsView)
    //
    ////        self.adsFramework = (TopVideoWithBottomProductDetails.instanceFromNib(producttitle: "Product 1") as! TopVideoWithBottomProductDetails)
    //        self.adsFramework1.isHidden = true
    //
    //
    //        self.adsFramework1.loaded = { isLoaded, viewHeight in
    //            self.adsFramework1.isHidden = !isLoaded
    //            DispatchQueue.main.async {
    //                if isLoaded && self.adsFramework1.frame.size.height != viewHeight {
    //                    self.adsFramework1.frame = CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: viewHeight)
    //                } else {
    //                    if !isLoaded {
    //                        self.adsFramework1.frame = CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 0)
    //                    }
    //                }
    //            }
    //        }
    //        self.view.addSubview(self.adsFramework1)
    //    }
    
    func setupAd1View() {
        let brandAd = BrandAdView(frame: self.ads1View.bounds)
        DispatchQueue.main.async { [self] in
            self.ads1View.isHidden = true
            self.ad1HeightConstraint.constant = 0
            brandAd.frame = self.ads1View.bounds
            self.ads1View.addSubview(brandAd)
            brandAd.loaded = { isLoaded, viewHeight in
                self.ads1View.isHidden = !isLoaded
                if isLoaded && self.ads1View.frame.size.height != viewHeight {
                    self.ad1HeightConstraint.constant = viewHeight
                } else {
                    if !isLoaded {
                        self.ad1HeightConstraint.constant = 0
                    }
                }
            }
        }
        brandAd.advertisementTapped = { brandId in
            print("Video tapped for barndID", brandId)
        }
    }
    
    func setupAd2View() {
        self.ad2HeightConstraint.constant = 0
        let productAd = (ProductVideoAdWithProductDetailsView.instanceFromNib(producttitle: "") as! ProductVideoAdWithProductDetailsView)
        DispatchQueue.main.async {
            productAd.isHidden = true
            productAd.frame = self.ads2View.bounds
            self.ads2View.addSubview(productAd)
            productAd.loaded = { isLoaded, viewHeight in
                productAd.isHidden = !isLoaded
                if isLoaded && self.ad2HeightConstraint.constant != viewHeight {
                    self.ad2HeightConstraint.constant = viewHeight
                } else {
                    if !isLoaded {
                        self.ad2HeightConstraint.constant = 0
                    }
                }
            }
        }
        productAd.advertisementTapped = { productId in
            print("Video tapped for productID", productId)
        }
    }
    
    func setupAd3View() {
        self.ad3HeightConstraint.constant = 0
        self.ads3View.isHidden = true
        let topVideoAdView = (TopVideoWithBottomProductDetails.instanceFromNib(producttitle: "Product 1") as! TopVideoWithBottomProductDetails)
        DispatchQueue.main.async {
            topVideoAdView.frame = self.ads3View.bounds
            self.ads3View.addSubview(topVideoAdView)
            topVideoAdView.loaded = { isLoaded, viewHeight in
                self.ads3View.isHidden = !isLoaded
                
                if isLoaded && self.ads3View.frame.size.height != viewHeight {
                    
                    self.ad3HeightConstraint.constant = viewHeight
                } else {
                    if !isLoaded {
                        self.ad3HeightConstraint.constant = 0
                    }
                }
            }
        }
        
        topVideoAdView.advertisementTapped = { productId in
            print("Video tapped for productID", productId)
        }
    }
    
    func setupAd4View() {
        let productAd = ProductVideoDetailsHorizontalAd(frame: self.ads1View.bounds)
        DispatchQueue.main.async { [self] in
            self.ads1View.isHidden = true
            self.ad1HeightConstraint.constant = 0
            productAd.frame = self.ads1View.bounds
            self.ads1View.addSubview(productAd)
            productAd.loaded = { isLoaded, viewHeight in
                self.ads1View.isHidden = !isLoaded
                if isLoaded && self.ads1View.frame.size.height != viewHeight {
                    self.ad1HeightConstraint.constant = viewHeight
                } else {
                    if !isLoaded {
                        self.ad1HeightConstraint.constant = 0
                    }
                }
            }
        }
        productAd.advertisementTapped = { productSKU in
            print("Video tapped for Product SKU", productSKU)
        }
    }
    
    
}

