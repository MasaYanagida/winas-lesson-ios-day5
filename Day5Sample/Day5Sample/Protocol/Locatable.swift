//
//  Locatable.swift
//  Day5Sample
//
//  Created by 柳田昌弘 on 2021/01/04.
//

import MapKit

protocol Locatable: class {
    var location: CLLocationCoordinate2D { get }
    var mapColor: UIColor { get }
}
