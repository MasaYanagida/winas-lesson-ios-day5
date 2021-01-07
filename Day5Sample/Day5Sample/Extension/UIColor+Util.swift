//
//  UIColor+Util.swift
//  Day5Sample
//
//  Created by 柳田昌弘 on 2021/01/02.
//

import UIKit

extension UIColor {
    static func hexColor(_ hex: Int, alpha: CGFloat = 1.0) -> UIColor {
        let r = CGFloat((hex >> 16) & 0xFF) / 255.0
        let g = CGFloat((hex >> 8) & 0xFF) / 255.0
        let b = CGFloat(hex & 0xFF) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
    var hex: Int {
        var red = CGFloat(0)
        var green = CGFloat(0)
        var blue = CGFloat(0)
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        return Int(red * 255) << 16
            + Int(green * 255) << 8
            + Int(blue * 255)
    }
    class var appBlue: UIColor {
        return UIColor.hexColor(0x2683c6)
    }
    class var appRed: UIColor {
        return UIColor.hexColor(0xd31C03)
    }
}
