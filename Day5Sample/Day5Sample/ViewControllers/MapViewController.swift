//
//  MapViewController.swift
//  Day5Sample
//
//  Created by 柳田昌弘 on 2021/01/08.
//

import UIKit
import MapKit

import SnapKit

// MARK: MapViewController

class MapViewController<T: Locatable>: UIViewController, MKMapViewDelegate {
    var item: T? // some class instance implements Locatable
    
    fileprivate lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        var region = mapView.region
        region.span.latitudeDelta = 0.01
        region.span.longitudeDelta = 0.01
        mapView.setRegion(region, animated: false)
        view.addSubview(mapView)
        return mapView
    }()
    fileprivate var annotation: MapAnnotation<T>? = nil {
        willSet {
            // remove old value first
            if let annotation = self.annotation {
                mapView.removeAnnotation(annotation)
            }
        }
        didSet {
            if let annotation = self.annotation {
                mapView.centerCoordinate = annotation.coordinate
                mapView.addAnnotation(annotation)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = self.item {
            annotation = MapAnnotation<T>.create(item)
        }
        mapView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(0)
            make.bottom.equalTo(view).offset(0)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
        }
    }
    
    // MARK: - MKMapViewDelegate
        
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let mapAnnotation = annotation as? MapAnnotation<T>,
            let item = self.item else { return nil }
        let reuseIdentifier = MapAnnotationView<T>.getReuseIdentifier(item)
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MapAnnotationView<T> {
            return annotationView
        } else {
            let annotationView = MapAnnotationView<T>(annotation: mapAnnotation, reuseIdentifier: reuseIdentifier)
            annotationView.isEnabled = true
            annotationView.canShowCallout = false
            return annotationView
        }
    }
}
