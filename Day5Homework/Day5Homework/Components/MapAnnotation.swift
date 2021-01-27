//
//  MapAnnotation.swift
//  Day5Sample
//
//  Created by 柳田昌弘 on 2021/01/08.
//

import MapKit

class MapAnnotation<T: Locatable>: MKPointAnnotation {
    var item: T?
    
    class func create(_ item: T) -> MapAnnotation {
        let annotation = MapAnnotation()
        annotation.item = item
        annotation.coordinate = item.location
        return annotation
    }
}
