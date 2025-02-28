//
//  PinAnnotation.swift
//  ChargePoint
//
//  Created by Javidan on 17.02.25.
//

import Foundation
import MapKit

class CustomPinAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var imageName: String
    var dataSource: Any

    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, imageName: String, dataSource: Any) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
        self.dataSource = dataSource
    }
}
