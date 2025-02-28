//
//  MapNavigation.swift
//  ChargePoint
//
//  Created by Javidan on 17.02.25.
//

import Foundation
protocol MapNavigation: AnyObject {
    func dismissController()
    func goToDetail(with model: DetailModel)
    func goToRoute(model: DetailModel)
    func openWaze(lat: Double, lon: Double)
    func openGoogleMap(lat: Double, lon: Double)
    func openAppleMap(lat: Double, lon: Double)
}
