//
//  UIImageView+Util.swift
//  Day5Sample
//
//  Created by 柳田昌弘 on 2021/01/02.
//

import UIKit
import Kingfisher

// MARK: - UIImageView

extension UIImageView {
    // see - https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet
    func loadKingfisherImage(_ url: URL, placeholder: UIImage? = nil, completion: (() -> Void)? = nil) {
        kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [.transition(.fade(0.2))],
            progressBlock: nil
        ) { result in
            completion?()
        }
    }
}
