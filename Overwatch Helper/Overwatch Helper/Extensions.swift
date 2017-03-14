//
//  Extensions.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/11/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Extension

extension Array {
    
    /// For shuffling array
    ///
    /// - Returns: the shuffled array
    public mutating func shuffle() -> Array {
        //by generating random number and tell if odd
        return self.sorted(by: {_,_ in arc4random() % 2 > 0})
    }
}

extension UIColor {
    
    /// Init UIColor with RBG Int <=255
    ///
    /// - Parameters:
    ///   - red: r
    ///   - green: g
    ///   - blue: b
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    
    /// Init UICOlor with Hex number
    ///
    /// - Parameter netHex: The hex representation for the color
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
