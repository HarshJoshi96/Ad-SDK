//
//  Utils.swift
//  Pods
//
//  Created by Abhishek.Batra on 6/27/23.
//

import Foundation
import AVFoundation

class Utils {
    static func getAdLabel() -> UILabel {
        let lblAd = UILabel(frame: CGRect(x: 10, y: 10, width: 25, height: 20))
        lblAd.text = "Ad"
        lblAd.font = UIFont.systemFont(ofSize: 12)
        lblAd.backgroundColor = UIColor.lightGray
        lblAd.textColor = .white
        lblAd.textAlignment = .center
        lblAd.layer.cornerRadius = 3
        lblAd.clipsToBounds = true
        return lblAd
        
    }
}
enum AdTypes: String {
    case brandAd = "brandAd"
    case horizontalTextAd = "horizontalTextAd"
    case verticalTextAd = "verticalTextAd"
}

extension AVPlayer{

    var isPlaying: Bool{
        return rate != 0 && error == nil
    }
}
