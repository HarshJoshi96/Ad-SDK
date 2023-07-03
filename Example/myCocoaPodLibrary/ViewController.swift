//
//  ViewController.swift
//  myCocoaPodLibrary
//
//  Created by 66667656 on 06/26/2023.
//  Copyright (c) 2023 66667656. All rights reserved.
//

import UIKit
import myCocoaPodLibrary

class ViewController: UIViewController {
    
    private var adsFramework3: TopVideoWithBottomProductDetails!
    private var adsFramework2: ProductVideoAdWithProductDetailsView!
    private var adsFramework1: BrandAdView!
    
    @IBOutlet weak var scrollViewContainer: UIView!
    @IBOutlet weak var ads1View: BrandAdView!
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
        
        self.ads1View.isHidden = false
        self.ads1View.loaded = { isLoaded, viewHeight in
            self.ads1View.isHidden = !isLoaded
            DispatchQueue.main.async {
                if isLoaded && self.ads1View.frame.size.height != viewHeight {
                    self.ad1HeightConstraint.constant = viewHeight
                } else {
                    if !isLoaded {
                        self.ad1HeightConstraint.constant = 0
                    }
                }
            }
        }
        self.ads1View.advertisementTapped = { brandId in
            print("Video tapped for barndID", brandId)
        }
    }
    
    func setupAd2View() {
        self.ad2HeightConstraint.constant = 0
        self.adsFramework2 = (ProductVideoAdWithProductDetailsView.instanceFromNib(producttitle: "") as! ProductVideoAdWithProductDetailsView)
        self.adsFramework2.isHidden = true
        self.adsFramework2.loaded = { isLoaded, viewHeight in
            self.adsFramework2.isHidden = !isLoaded
            DispatchQueue.main.async {
                if isLoaded && self.ad2HeightConstraint.constant != viewHeight {
                    
                    self.adsFramework2.frame = self.ads2View.bounds
                    self.ads2View.addSubview(self.adsFramework2)
                    self.ad2HeightConstraint.constant = viewHeight
                } else {
                    if !isLoaded {
                        self.ad2HeightConstraint.constant = 0
                    }
                }
            }
        }
        self.adsFramework2.advertisementTapped = { productId in
            print("Video tapped for productID", productId)
        }
    }
    
    func setupAd3View() {
        self.ad3HeightConstraint.constant = 0
        self.ads3View.isHidden = true
        let topVideoAdView = (TopVideoWithBottomProductDetails.instanceFromNib(producttitle: "Product 1") as! TopVideoWithBottomProductDetails)
        topVideoAdView.loaded = { isLoaded, viewHeight in
            self.ads3View.isHidden = !isLoaded
            DispatchQueue.main.async {
                if isLoaded && self.ads3View.frame.size.height != viewHeight {
                    topVideoAdView.frame = self.ads3View.bounds
                    self.ads3View.addSubview(topVideoAdView)
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
    

}

