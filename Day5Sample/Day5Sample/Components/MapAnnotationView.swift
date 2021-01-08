//
//  MapAnnotationView.swift
//  Day5Sample
//
//  Created by 柳田昌弘 on 2021/01/08.
//

import MapKit

class MapAnnotationView<T: Locatable>: MKAnnotationView {
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = .clear
        addSubview(imageView)
        return imageView
    }()
    
    class func getReuseIdentifier(_ item: T) -> String {
        let identifier: String = "map_\(item.mapColor.hex)"
        return identifier
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.clearsContextBeforeDrawing = true
        self.layer.anchorPoint = CGPoint(x: 0.5, y: 1) // bottom & center
        
        guard let mapAnnotation = annotation as? MapAnnotation<T>,
          let item = mapAnnotation.item,
          let iconImage = UIImage.faSolidIcon(icon: .mapMarkerAlt, color: item.mapColor, fontSize: 40) else {
            return
        }
        frame = CGRect(x: 0, y: 0, width: iconImage.size.width, height: iconImage.size.height)
        iconView.image = iconImage
        iconView.frame = CGRect(x: 0, y: 0, width: iconImage.size.width, height: iconImage.size.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
