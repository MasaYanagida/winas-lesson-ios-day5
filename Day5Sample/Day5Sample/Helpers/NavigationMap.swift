//
//  NavigationMap.swift
//  Day5Sample
//
//  Created by 柳田昌弘 on 2021/01/05.
//

import Foundation

import URLNavigator

// MARK: NavigationMap

enum NavigationMap {
    static let navigator = Navigator()
    static func initialize() {
        navigator.register("winas://hospital/<int:id>") { url, values, _ in
            guard let hospitalId = values["id"] as? Int else {
                return nil
            }
            let controller = HospitalDetailViewController.fromStoryboard()
            controller.hospitalId = hospitalId
            return controller
        }

        navigator.register("winas://restaurant/<int:id>") { url, values, _ in
            guard let restaurantId = values["id"] as? Int else {
                return nil
            }
            let controller = RestaurantDetailViewController.fromStoryboard()
            controller.restaurantId = restaurantId
            return controller
        }
    }
}
