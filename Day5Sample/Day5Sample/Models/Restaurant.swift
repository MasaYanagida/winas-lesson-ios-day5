//
//  Restaurant.swift
//  Day5Sample
//
//  Created by 柳田昌弘 on 2021/01/04.
//

import Foundation
import CoreLocation

import ObjectMapper

// MARK: RestaurantCategory

enum RestaurantCategory: Int {
    case ramen = 1, italian = 2
    var text: String {
        switch self {
        case .ramen: return "ラーメン"
        case .italian: return "イタリアン"
        }
    }
}

// MARK: Restaurant

class Restaurant: Mappable, Feedable, Locatable {
    var id: Int = 0
    var name: String = ""
    var categoryId: Int = 0
    var address: String = ""
    var phone: String = ""
    var photoUrl: String = ""
    var latitude: Double = 0
    var longitude: Double = 0
    
    var category: RestaurantCategory? {
        return RestaurantCategory(rawValue: categoryId)
    }
    
    // Feedable
    var feedContentType: FeedContentType {
        return .restraunt
    }
    
    // Locatable
    var location: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(latitude, longitude)
    }
    var mapColor: UIColor {
        return .appRed
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        categoryId <- map["category"]
        address <- map["address"]
        phone <- map["phone"]
        photoUrl <- map["photo_url"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }
}
