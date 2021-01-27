//
//  HospitalDetailViewController.swift
//  Day5Sample
//
//  Created by 柳田昌弘 on 2021/01/05.
//

import UIKit
import MapKit

import BonMot

// MARK: HospitalDetailViewController

class HospitalDetailViewController: UIViewController {
    
    var hospital: Hospital? {
        didSet {
            updateView()
        }
    }
    var hospitalId: Int = 0 {
        didSet {
            Service.content.getHospital(
                hospitalId: hospitalId,
                completion: { hospital in
                    self.hospital = hospital
                },
                failure: nil)
        }
    }
    
    private var annotation: MapAnnotation<Hospital>? = nil {
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
        guard isViewLoaded, let hospital = self.hospital else { return }
        nameLabel.attributedText = hospital.fullName.styled(with: StringStyle(
            .font(.defaultBold(15)), .color(UIColor.hexColor(0x222222)), .lineSpacing(4)
        ))
        departmentsLabel.attributedText = hospital.departments.map { $0.text }.joined(separator: ",").styled(with: StringStyle(
            .font(.default(12)), .color(.appBlue), .lineSpacing(4)
        ))
        
        let addressIconString = FontAwesomeSolidIcon.mapMarkerAlt.text.styled(with: StringStyle(
            .font(.faSolid(12)), .color(UIColor.hexColor(0x999999))
        ))
        let addressString = hospital.address.styled(with: StringStyle(
            .font(.default(12)), .color(UIColor.hexColor(0x999999)), .lineSpacing(4)
        ))
        addressLabel.attributedText = [addressIconString, addressString].joined(separator: " ")
        
        let phoneIconString = FontAwesomeSolidIcon.phone.text.styled(with: StringStyle(
            .font(.faSolid(12)), .color(UIColor.hexColor(0x999999))
        ))
        let phoneString = hospital.phone.styled(with: StringStyle(
            .font(.default(12)), .color(UIColor.hexColor(0x999999)), .lineSpacing(4)
        ))
        phoneLabel.attributedText = [phoneIconString, phoneString].joined(separator: " ")
        
        annotation = MapAnnotation<Hospital>.create(hospital)
    }
    
    // MARK: Private
    @IBOutlet fileprivate dynamic weak var iconView: UIImageView! {
        didSet {
            iconView.image = UIImage.faSolidIcon(icon: .hospital, color: .appBlue, fontSize: 32)
        }
    }
    @IBOutlet fileprivate dynamic weak var nameLabel: UILabel!
    @IBOutlet fileprivate dynamic weak var departmentsLabel: UILabel!
    @IBOutlet fileprivate dynamic weak var addressLabel: UILabel!
    @IBOutlet fileprivate dynamic weak var phoneLabel: UILabel!
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

extension HospitalDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let mapAnnotation = annotation as? MapAnnotation<Hospital>,
              let hospital = self.hospital else { return nil }
        let reuseIdentifier = MapAnnotationView<Hospital>.getReuseIdentifier(hospital)
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MapAnnotationView<Hospital> {
            return annotationView
        } else {
            let annotationView = MapAnnotationView<Hospital>(annotation: mapAnnotation, reuseIdentifier: reuseIdentifier)
            annotationView.isEnabled = true
            annotationView.canShowCallout = false
            return annotationView
        }
    }
}

// MARK: - StoryboardInstantiable

extension HospitalDetailViewController: StoryboardInstantiable {
    static var storyboardName: String {
        return String(describing: self)
    }
}
