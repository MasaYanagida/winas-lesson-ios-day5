//
//  RestaurantDetailViewController.swift
//  Day5Sample
//
//  Created by 柳田昌弘 on 2021/01/05.
//

import UIKit
import MapKit

import BonMot

// MARK: RestaurantDetailViewController

class RestaurantDetailViewController: UIViewController {
    
    var restaurant: Restaurant? {
        didSet {
            updateView()
        }
    }
    var restaurantId: Int = 0 {
        didSet {
            Service.content.getRestaurant(
                restaurantId: restaurantId,
                completion: { restaurant in
                    self.restaurant = restaurant
                },
                failure: nil)
        }
    }
    
    private var annotation: MapAnnotation<Restaurant>? = nil {
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
        updateView()
    }
    
    private func updateView() {
        guard isViewLoaded, let restaurant = self.restaurant else { return }
        nameLabel.attributedText = restaurant.name.styled(with: StringStyle(
            .font(.defaultBold(15)), .color(UIColor.hexColor(0x222222)), .lineSpacing(4)
        ))
        categoryLabel.attributedText = (restaurant.category?.text ?? "").styled(with: StringStyle(
            .font(.default(12)), .color(.appRed), .lineSpacing(4)
        ))
        
        let addressIconString = FontAwesomeSolidIcon.mapMarkerAlt.text.styled(with: StringStyle(
            .font(.faSolid(12)), .color(UIColor.hexColor(0x999999))
        ))
        let addressString = restaurant.address.styled(with: StringStyle(
            .font(.default(12)), .color(UIColor.hexColor(0x999999)), .lineSpacing(4)
        ))
        addressLabel.attributedText = [addressIconString, addressString].joined(separator: " ")
        
        if let photoUrl = URL(string: restaurant.photoUrl) {
            photoView.loadKingfisherImage(photoUrl)
        }
        
        annotation = MapAnnotation<Restaurant>.create(restaurant)
    }
    
    // MARK: Private
    @IBOutlet fileprivate dynamic weak var iconView: UIImageView! {
        didSet {
            iconView.image = UIImage.faSolidIcon(icon: .restaurant, color: .appRed, fontSize: 32)
        }
    }
    @IBOutlet fileprivate dynamic weak var nameLabel: UILabel!
    @IBOutlet fileprivate dynamic weak var categoryLabel: UILabel!
    @IBOutlet fileprivate dynamic weak var addressLabel: UILabel!
    @IBOutlet fileprivate dynamic weak var photoView: UIImageView!
    @IBOutlet fileprivate dynamic weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
            var region = mapView.region
            region.span.latitudeDelta = 0.01
            region.span.longitudeDelta = 0.01
            mapView.setRegion(region, animated: false)
        }
    }
}

// MARK: - MKMapViewDelegate

extension RestaurantDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let mapAnnotation = annotation as? MapAnnotation<Restaurant>,
              let restaurant = self.restaurant else { return nil }
        let reuseIdentifier = MapAnnotationView<Restaurant>.getReuseIdentifier(restaurant)
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MapAnnotationView<Restaurant> {
            return annotationView
        } else {
            let annotationView = MapAnnotationView<Restaurant>(annotation: mapAnnotation, reuseIdentifier: reuseIdentifier)
            annotationView.isEnabled = true
            annotationView.canShowCallout = false
            return annotationView
        }
    }
}

// MARK: - StoryboardInstantiable

extension RestaurantDetailViewController: StoryboardInstantiable {
    static var storyboardName: String {
        return String(describing: self)
    }
}
