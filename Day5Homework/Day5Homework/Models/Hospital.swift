//
//  Hospital.swift
//  Day5Sample
//
//  Created by 柳田昌弘 on 2021/01/04.
//

import Foundation
import CoreLocation

import ObjectMapper

// MARK: HospitalDepartment

enum HospitalDepartment: Int {
    case ladies = 1, `internal` = 2, respiratory = 3, cardiology = 4, dermatology = 5
    var text: String {
        switch self {
        case .ladies: return "婦人科"
        case .internal: return "一般内科"
        case .respiratory: return "呼吸器内科"
        case .cardiology: return "循環器内科"
        case .dermatology: return "皮膚科"
        }
    }
}

// MARK: Hospital

class Hospital: Mappable, Feedable, Locatable {
    var id: Int = 0
    var name: String = ""
    var fullName: String = ""
    var departmentIds = [Int]()
    var president: String = ""
    var address: String = ""
    var phone: String = ""
    var website: String = ""
    var latitude: Double = 0
    var longitude: Double = 0
    
    var departments: [HospitalDepartment] {
        return departmentIds.compactMap { HospitalDepartment(rawValue: $0) }
    }
    
    // Feedable
    var feedContentType: FeedContentType {
        return .hospital
    }
    
    // Locatable
    var location: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(latitude, longitude)
    }
    var mapColor: UIColor{
        return .appBlue
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        fullName <- map["full_name"]
        departmentIds <- map["departments"]
        president <- map["president"]
        address <- map["address"]
        phone <- map["phone"]
        website <- map["website"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }
}
