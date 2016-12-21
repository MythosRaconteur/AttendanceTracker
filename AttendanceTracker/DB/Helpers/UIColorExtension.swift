//
//  UIColorExtension.swift
//  AttendanceTracker
//
//  Created by Christopher Burns on 12/11/16.
//  Copyright © 2016 Mythos Productions. All rights reserved.
//

import UIKit

extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString.substring(from: start)
            
            if hexColor.characters.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
    
    class func flakBrown() -> UIColor {
        return UIColor(hexString: "#804000FF")!
    }
    
    class func flakRed() -> UIColor {
        return UIColor(hexString: "#800000FF")!
    }
    
    class func flakLightGray() -> UIColor {
        return UIColor(hexString: "#DDDDDDFF")!
    }
    
    class func flakMaleBlue() -> UIColor {
        return UIColor(hexString: "#0080FFFF")!
    }
    
    class func flakFemalePink() -> UIColor {
        return UIColor(hexString: "#FF66FFFF")!
    }
    
    class func flakGrouponGreen() -> UIColor {
        return UIColor(hexString: "#76B065FF")!
    }
    
    class func flakDarkTeal() -> UIColor {
        return UIColor(hexString: "#64A0A0FF")!
    }
    
    class func flakTeal() -> UIColor {
        return UIColor(hexString: "#00A0A0FF")!
    }
    
    class func flakBurgundy() -> UIColor {
        return UIColor(hexString: "#A03030FF")!
    }
}
