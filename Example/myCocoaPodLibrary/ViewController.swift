//
//  ViewController.swift
//  inmobi-ios-adSDK
//
//  Created by 135563768 on 06/30/2023.
//  Copyright (c) 2023 135563768. All rights reserved.
//

import UIKit
import myCocoaPodLibrary
import AVFoundation
import WebKit
import SafariServices
import MetricKit
import os.log

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
        let metricManager = MXMetricManager.shared
        if #available(iOS 14.0, *) {
            metricManager.add(self)
        } else {
            // Fallback on earlier versions
        }
//        let inMobiAdType = SelectAdOption(frame: self.ads1View.bounds, width: Int(self.view.frame.size.width), typeAd: "brandAd")
//
//        inMobiAdType.videoLoaded = { adView, isLoaded, viewHeight in
//            self.ads1View.isHidden = !isLoaded
//            DispatchQueue.main.async {
//                if isLoaded && self.ads1View.frame.size.height != viewHeight {
//                    self.ads1View.addSubview(adView)
//                    self.ad1HeightConstraint.constant = viewHeight
//                } else {
//                    if !isLoaded {
//                        self.ads1View.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
//                    }
//                }
//            }
//        }
//        inMobiAdType.itemAdvertisementTapped = { brandId in
//            print("Video tapped for barndID", brandId)
//        }
        self.ad1HeightConstraint.constant = 0
        let myView = MyAdView.createView(withName: "BrandAd", viewWidth: self.view.frame.size.width) { isLoaded, viewHeight in
            DispatchQueue.main.async {
                self.ads1View.isHidden = !isLoaded
            }
            
            if isLoaded && self.ads1View.frame.size.height != viewHeight {
                
                self.ad1HeightConstraint.constant = viewHeight
            } else {
                if !isLoaded {
                    self.ad1HeightConstraint.constant = 0
                }
            }
        } callbackValue2: { brandId in
            print("Video tapped for barndID", brandId)
        }
        myView?.frame = self.ads1View.bounds
        self.ads1View.addSubview(myView ?? UIView())
        
//        self.ads1View.addSubview(webView)
        self.ad2HeightConstraint.constant = 0
        let myView2 = MyAdView.createView(withName: "HorizontalVvw", viewWidth: self.view.frame.size.width) { isLoaded, viewHeight in
            DispatchQueue.main.async {
                self.ads2View.isHidden = !isLoaded
            }
            if isLoaded && self.ads2View.frame.size.height != viewHeight {
                self.ad2HeightConstraint.constant = viewHeight
            } else {
                if !isLoaded {
                    self.ad2HeightConstraint.constant = 0
                }
            }
        } callbackValue2: { brandId in
            print("Video tapped for barndID", brandId)
        }
        myView2?.frame = self.ads2View.bounds
        self.ads2View.addSubview(myView2 ?? UIView())
        
        let html = HtmlViewAd(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50), controller: self)
        
        self.ads3View.addSubview(html)
        
//        let brandAd = BrandAdView(frame: self.ads1View.bounds, videoItem: AVPlayer())
//                DispatchQueue.main.async { [self] in
//                    self.ads1View.isHidden = true
//                    self.ad1HeightConstraint.constant = 0
//                    brandAd.frame = self.ads1View.bounds
//                    self.ads1View.addSubview(brandAd)
//                    brandAd.loaded = { isLoaded, viewHeight in
//                        self.ads1View.isHidden = !isLoaded
//                        if isLoaded && self.ads1View.frame.size.height != viewHeight {
//                            self.ad1HeightConstraint.constant = viewHeight
//                        } else {
//                            if !isLoaded {
//                                self.ad1HeightConstraint.constant = 0
//                            }
//                        }
//                    }
//                }
//                brandAd.advertisementTapped = { brandId in
//                    print("Video tapped for barndID", brandId)
//                }
        
        
//        let inMobiAdType2 = SelectAdOption(frame: self.ads1View.bounds, width: Int(self.view.frame.size.width), typeAd: "brandAd")
//
//        inMobiAdType2.videoLoaded = { adView, isLoaded, viewHeight in
//            self.ads1View.isHidden = !isLoaded
//            DispatchQueue.main.async {
//                if isLoaded && self.ads1View.frame.size.height != viewHeight {
//                    self.view.addSubview(adView)
//                } else {
//                    if !isLoaded {
//                        self.ads1View.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
//                    }
//                }
//            }
//        }
//        inMobiAdType2.itemAdvertisementTapped = { brandId in
//            print("Video tapped for barndID", brandId)
//        }
        
        
        
//        self.view.addSubview(mv)
//        setupAd1View()
//        setupAd2View()
//        setupAd3View()
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
    
//    func setupAd1View() {
//        let brandAd = BrandAdView(frame: self.ads1View.bounds, vieo: AVPlayer())
//        DispatchQueue.main.async { [self] in
//            self.ads1View.isHidden = true
//            self.ad1HeightConstraint.constant = 0
//            brandAd.frame = self.ads1View.bounds
//            self.ads1View.addSubview(brandAd)
//            brandAd.loaded = { isLoaded, viewHeight in
//                self.ads1View.isHidden = !isLoaded
//                if isLoaded && self.ads1View.frame.size.height != viewHeight {
//                    self.ad1HeightConstraint.constant = viewHeight
//                } else {
//                    if !isLoaded {
//                        self.ad1HeightConstraint.constant = 0
//                    }
//                }
//            }
//        }
//        brandAd.advertisementTapped = { brandId in
//            print("Video tapped for barndID", brandId)
//        }
//    }
    
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
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        var action: WKNavigationActionPolicy?
//
//        defer {
//            decisionHandler(action ?? .allow)
//        }
//
//        guard let url = navigationAction.request.url else { return }
//
//        print(url)
//
//        if navigationAction.navigationType == .linkActivated, url.absoluteString.hasPrefix("http://www.example.com/open-in-safari") {
//            action = .cancel                  // Stop in WebView
//            UIApplication.shared.open(url)    // Open in Safari
//        }
//    }
    
//    func setupAd4View() {
//        let productAd = ProductVideoDetailsHorizontalAd(frame: self.ads1View.bounds)
//        DispatchQueue.main.async { [self] in
//            self.ads1View.isHidden = true
//            self.ad1HeightConstraint.constant = 0
//            productAd.frame = self.ads1View.bounds
//            self.ads1View.addSubview(productAd)
//            productAd.loaded = { isLoaded, viewHeight in
//                self.ads1View.isHidden = !isLoaded
//                if isLoaded && self.ads1View.frame.size.height != viewHeight {
//                    self.ad1HeightConstraint.constant = viewHeight
//                } else {
//                    if !isLoaded {
//                        self.ad1HeightConstraint.constant = 0
//                    }
//                }
//            }
//        }
//        productAd.advertisementTapped = { productSKU in
//            print("Video tapped for Product SKU", productSKU)
//        }
//    }
    
    
}

extension ViewController: WKNavigationDelegate {
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            
            print("Start loading")
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//            self.loader.hideLoader()
            print("End loading")
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            
            var action: WKNavigationActionPolicy?
            
                    defer {
                        decisionHandler(action ?? .allow)
                    }
            
                    guard let url = navigationAction.request.url else { return }
            
                    print(url)
            
                    if navigationAction.navigationType == .linkActivated, url.absoluteString.hasPrefix("https:") {
                        action = .cancel                  // Stop in WebView
                      
                                let config = SFSafariViewController.Configuration()
                                config.entersReaderIfAvailable = true

                                let vc = SFSafariViewController(url: url, configuration: config)
                                present(vc, animated: true)

                    }
//            switch navigationAction.navigationType {
//            case .linkActivated:
////                if navigationAction.targetFrame == nil {
////                    self.webView?.load(navigationAction.request)// It will load that link in same WKWebView
////
////                }
//            default:
//                break
//
//            }
//
//            if let url = navigationAction.request.url {
//                debugPrint(url.absoluteString) // It will give the selected link URL
//                UIApplication.shared.open(url)
//                decisionHandler(.cancel)
//
//            }
//            else {
//                decisionHandler(.allow)
//            }
            
        }

}
@available(iOS 14.0, *)
extension ViewController: MXMetricManagerSubscriber {
    func didReceive(_ payloads: [MXMetricPayload]) {
           os_log("Received Daily MXMetricPayload:", type: .debug)
           for metricPayload in payloads {
               if let metricPayloadJsonString = String(data: metricPayload.jsonRepresentation(), encoding: .utf8) {
                   os_log("%@", type: .debug, metricPayloadJsonString)
    
                   // Here you could upload these metrics (in JSON form) to your servers to aggregate app performance metrics
               }
           }
       }
        
       // called at most once every 24hrs with daily app diagnostics
       @available(iOS 14.0, *)
       func didReceive(_ payloads: [MXDiagnosticPayload]) {
           os_log("Received Daily MXDiagnosticPayload:", type: .debug)
           for diagnosticPayload in payloads {
               if let diagnosticPayloadJsonString = String(data: diagnosticPayload.jsonRepresentation(), encoding: .utf8) {
                   os_log("%@", type: .debug, diagnosticPayloadJsonString)
    
                   // Here you could upload these metrics (in JSON form) to your servers to aggregate app performance metrics
               }
           }
       }
}
