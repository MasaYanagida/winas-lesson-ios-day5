//
//  StoryboardInstantiable.swift
//  Day5Sample
//
//  Created by 柳田昌弘 on 2021/01/05.
//

import UIKit

protocol StoryboardInstantiable {
    static var storyboardName: String { get }
}

extension StoryboardInstantiable where Self: UIViewController {
    static func fromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as? Self
        if controller == nil {
            assert(false, "生成したいViewControllerと同じ名前のStorybaordが見つからないか、Initial ViewControllerに設定されていない可能性があります。")
        }
        return controller!
    }
}
