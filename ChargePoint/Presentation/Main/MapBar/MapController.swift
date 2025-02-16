//
//  MapController.swift
//  ChargePoint
//
//  Created by Javidan on 16.02.25.
//

import UIKit
import MapKit

final class MapController: BaseController {

    private lazy var mapView: MKMapView = {
        let m = MKMapView()
        m.delegate = self
        m.overrideUserInterfaceStyle = .dark
        return m
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    override func configureView() {
        super.configureView()
        view.addViews(view: [mapView])
    }
    override func configureConstraints() {
        super.configureConstraints()
        mapView.fillSuperview()
    }

}
extension MapController: MKMapViewDelegate {
    
}
