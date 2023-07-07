//
//  SelectAdView.swift
//  inmobi-ios-adSDK
//
//  Created by Harsh.Joshi on 06/07/23.
//

import Foundation
public class SelectAdOption: NSObject {
    private var ads1View: BrandAdView!
    var width: Int!
    var vframe: CGRect!
    var typeAd:String!
    open var videoLoaded: ((UIView, Bool, CGFloat)->())!
    open var itemAdvertisementTapped: ((String)->())!
    public init(frame: CGRect,width: Int,typeAd: String){
        self.vframe = frame
        self.width = width
        self.typeAd = typeAd
        super.init()
        print(AdTypes.brandAd.rawValue, typeAd)
        if typeAd ==  AdTypes.brandAd.rawValue {
            setupAd1View(viewWidth: width)
        }else if typeAd ==  AdTypes.horizontalTextAd.rawValue {
            setupAd2View(viewWidth: width)
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
    
    func setupAd1View(viewWidth:Int) {
        self.ads1View = BrandAdView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: 0))
        
        self.ads1View.isHidden = true
        self.ads1View.loaded = { isLoaded, viewHeight in
            self.ads1View.isHidden = !isLoaded
            DispatchQueue.main.async {
                if isLoaded && self.ads1View.frame.size.height != viewHeight {
                    self.ads1View.frame = CGRect(x: 0, y: 0, width: viewWidth, height: Int(viewHeight))
                    self.videoLoaded(self.ads1View, true, viewHeight)
                } else {
                    if !isLoaded {
                        self.videoLoaded(self.ads1View, false, 0)
                    }
                }
            }
        }
        self.ads1View.advertisementTapped = {productDetails in
            self.itemAdvertisementTapped(productDetails)
        }
    }
    
    func setupAd2View(viewWidth:Int) {
        let productAd = ProductVideoDetailsHorizontalAd(frame: CGRect(x: 0, y: 0, width: viewWidth, height: 0))
        DispatchQueue.main.async { [self] in
            productAd.isHidden = true
            productAd.loaded = { isLoaded, viewHeight in
                productAd.isHidden = !isLoaded
                if isLoaded && productAd.frame.size.height != viewHeight {
                    productAd.frame = CGRect(x: 0, y: 0, width: viewWidth, height: Int(viewHeight))
                    self.videoLoaded(productAd, true, viewHeight)
                    print("in setup view")
                } else {
                    if !isLoaded {
                        productAd.frame = CGRect(x: 0, y: 0, width: viewWidth, height: 0)
                    }
                }
            }
        }
        productAd.advertisementTapped = { productSKU in
            self.itemAdvertisementTapped(productSKU as String)
            print("Video tapped for Product SKU", productSKU)
        }
    }
}
