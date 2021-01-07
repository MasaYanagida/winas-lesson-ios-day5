//
//  RestaurantTableViewCell.swift
//  Day5Sample
//
//  Created by 柳田昌弘 on 2021/01/04.
//

import UIKit
import BonMot

// MARK: RestaurantTableViewCellDelegate

protocol RestaurantTableViewCellDelegate : class {
    func restaurantTableViewCell(mapButtonTouchUpInside cell: RestaurantTableViewCell)
}

// MARK: RestaurantTableViewCell

class RestaurantTableViewCell: UITableViewCell {
    
    // MARK: Internal
    weak var delegate: RestaurantTableViewCellDelegate?
    var restaurant: Restaurant? {
        didSet {
            guard let restaurant = self.restaurant else {
                return
            }
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
        }
    }
    
    // MARK: Private
    @IBOutlet fileprivate dynamic weak var iconView: UIImageView! {
        didSet {
            iconView.image = UIImage.faSolidIcon(icon: .restaurant, color: .appRed, fontSize: 32)
        }
    }
    @IBOutlet fileprivate dynamic weak var mapButton: UIButton! {
        didSet {
            let iconString = FontAwesomeRegularIcon.map.text.styled(with: StringStyle(
                .font(.faRegular(14)), .color(.white)
            ))
            let textString = "地図".styled(with: StringStyle(
                .font(.defaultBold(12)), .color(.white)
            ))
            mapButton.setAttributedTitle([iconString, textString].joined(separator: " "), for: .normal)
        }
    }
    @IBOutlet fileprivate dynamic weak var nameLabel: UILabel!
    @IBOutlet fileprivate dynamic weak var categoryLabel: UILabel!
    @IBOutlet fileprivate dynamic weak var addressLabel: UILabel!
    @IBOutlet fileprivate dynamic weak var photoView: UIImageView!
    @IBAction func onMapButtonTouchUpOutside(_ sender: Any) {
        delegate?.restaurantTableViewCell(mapButtonTouchUpInside: self)
    }
}
