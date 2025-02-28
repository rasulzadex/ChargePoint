//
//  RouteViewModel.swift
//  ChargePoint
//
//  Created by Javidan on 27.02.25.
//

import Foundation
final class RouteViewModel {
    let detail: DetailModel
    private weak var navigation: MapNavigation?
    init(navigation: MapNavigation?, detail: DetailModel) {
        self.navigation = navigation
        self.detail = detail
    }
    func dismissController(){
        navigation?.dismissController()
    }
    func openWaze(){
        navigation?.openWaze(lat: detail.latitude, lon: detail.longitude)
    }
    func openGoogleMaps() {
        navigation?.openGoogleMap(lat: detail.latitude, lon: detail.longitude)
    }
    func openAppleMaps(){
        navigation?.openAppleMap(lat: detail.latitude, lon: detail.longitude)
    }
}
