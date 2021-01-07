//
//  UIFont+Util.swift
//  Day5Sample
//
//  Created by 柳田昌弘 on 2021/01/02.
//

import UIKit

// MARK: - UIFont

extension UIFont {
    class func `default`(_ ofSize: CGFloat) -> UIFont {
        return UIFont(name: "HiraginoSans-W3", size: ofSize)!
    }
    class func defaultBold(_ ofSize: CGFloat) -> UIFont {
        return UIFont(name: "HiraginoSans-W6", size: ofSize)!
    }
    class func faRegular(_ ofSize: CGFloat) -> UIFont {
        return UIFont(name: "FontAwesome5Free-Regular", size: ofSize)!
    }
    class func faSolid(_ ofSize: CGFloat) -> UIFont {
        return UIFont(name: "FontAwesome5Free-Solid", size: ofSize)!
    }
}
