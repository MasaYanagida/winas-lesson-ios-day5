//
//  Locatable.swift
//  Day5Homework
//
//  Created by 杉浦祐一 on 2021/01/17.
//

import MapKit

protocol Locatable:class{
    var location: CLLocationCoordinate2D { get }
    var mapColor : UIColor { get }
    
}
