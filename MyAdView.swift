//
//  MyAdView.swift
//  myCocoaPodLibrary
//
//  Created by Harsh.Joshi on 12/07/23.
//
import AVKit
import Foundation


public class MyAdView {
    
    public class func createView(withName name: String, viewWidth: CGFloat, callbackValue1: @escaping ((Bool, CGFloat)->()), callbackValue2: @escaping ((String)->())) -> UIView? {
        if name == "BrandAd" {
            let customView = BrandAdView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: 0))
            customView.loaded = callbackValue1
            customView.advertisementTapped = callbackValue2
            return customView
        } else if name == "HorizontalVvw" {
            let customView = ProductVideoDetailsHorizontalAd(frame: CGRect(x: 0, y: 0, width: viewWidth, height: 0))
            customView.loaded = callbackValue1
            customView.advertisementTapped = callbackValue2
            return customView
        } else{
            return nil
        }
    }
}
