//
//  HospitalTableViewCell.swift
//  Day5Sample
//
//  Created by 柳田昌弘 on 2021/01/04.
//

import UIKit
import BonMot

// MARK: HospitalTableViewCellDelegate

protocol HospitalTableViewCellDelegate : class {
    func hospitalTableViewCell(mapButtonTouchUpInside cell: HospitalTableViewCell)
}

// MARK: HospitalTableViewCell

class HospitalTableViewCell: UITableViewCell {
    
    // MARK: Internal
    weak var delegate: HospitalTableViewCellDelegate?
    var hospital: Hospital? {
        didSet {
            guard let hospital = self.hospital else {
                return
            }
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
        }
    }
    
    // MARK: Private
    @IBOutlet fileprivate dynamic weak var iconView: UIImageView! {
        didSet {
            iconView.image = UIImage.faSolidIcon(icon: .hospital, color: .appBlue, fontSize: 32)
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
    @IBOutlet fileprivate dynamic weak var departmentsLabel: UILabel!
    @IBOutlet fileprivate dynamic weak var addressLabel: UILabel!
    @IBOutlet fileprivate dynamic weak var phoneLabel: UILabel!
    @IBAction func onMapButtonTouchUpOutside(_ sender: Any) {
        delegate?.hospitalTableViewCell(mapButtonTouchUpInside: self)
    }
}
