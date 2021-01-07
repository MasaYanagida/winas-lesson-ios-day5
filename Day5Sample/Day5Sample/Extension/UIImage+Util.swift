//
//  UIImage+Util.swift
//  Day5Sample
//
//  Created by 柳田昌弘 on 2021/01/02.
//

import UIKit

// MARK: - FontAwesomeSolidIcon
// CheatSheet - https://fontawesome.com/cheatsheet
enum FontAwesomeSolidIcon {
    case mapMarker, mapMarkerAlt, mapPin, hospital, restaurant, phone
    var text: String {
        switch self {
        case .mapMarker: return "\u{f041}"
        case .mapMarkerAlt: return "\u{f3c5}"
        case .mapPin: return "\u{f276}"
        case .hospital: return "\u{f47d}"
        case .restaurant: return "\u{f54f}"
        case .phone: return "\u{f095}"
        }
    }
}

// MARK: - FontAwesomeRegularIcon
// CheatSheet - https://fontawesome.com/cheatsheet/free/regular
enum FontAwesomeRegularIcon {
    case map
    var text: String {
        switch self {
        case .map: return "\u{f279}"
        }
    }
}

// MARK: - UIImage

extension UIImage {
    
    class func faSolidIcon(
        icon: FontAwesomeSolidIcon,
        color: UIColor,
        fontSize: CGFloat,
        size: CGSize? = nil
        ) -> UIImage? {
        let font = UIFont.faSolid(fontSize)
        return fontImage(font: font, name: icon.text, color: color, fontSize: fontSize, size: size)
    }
    class func faRegularIcon(
        icon: FontAwesomeRegularIcon,
        color: UIColor,
        fontSize: CGFloat,
        size: CGSize? = nil
        ) -> UIImage? {
        let font = UIFont.faRegular(fontSize)
        return fontImage(font: font, name: icon.text, color: color, fontSize: fontSize, size: size)
    }
    
    class func fontImage(
        font: UIFont,
        name: String,
        color: UIColor,
        fontSize: CGFloat,
        size: CGSize? = nil
        ) -> UIImage? {
        let attributes: [NSAttributedString.Key: AnyObject] = [
            NSAttributedString.Key.backgroundColor: UIColor.clear,
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color
        ]
        let attributeString = NSAttributedString(string: name, attributes: attributes)
        
        var imageSize: CGSize = CGSize.zero
        if let size = size {
            imageSize = size
        } else {
            imageSize = CGSize(width: fontSize, height: fontSize)
//            let stringSize = attributeString.size()
//            if stringSize.width > stringSize.height {
//                imageSize = CGSize(width: fontSize, height: fontSize * stringSize.height / stringSize.width)
//            } else {
//                imageSize = CGSize(width: fontSize * stringSize.width / stringSize.height, height: fontSize)
//            }
        }
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0.0)
        
        let ctx = NSStringDrawingContext()
        let boundingRect = attributeString.boundingRect(with: CGSize(width: fontSize, height: fontSize), options: .usesLineFragmentOrigin, context: ctx)
        attributeString.draw(in: CGRect(
            x: (imageSize.width/2.0) - boundingRect.size.width/2.0,
            y: (imageSize.height/2.0) - boundingRect.size.height/2.0,
            width: imageSize.width,
            height: imageSize.height
            )
        )
        if let iconImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return iconImage
        }
        return nil
    }
}
