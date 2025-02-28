//
//  DetailVIewModel.swift
//  ChargePoint
//
//  Created by Javidan on 18.02.25.
//

import Foundation
final class DetailViewModel {
    let detail: DetailModel
    private weak var navigation: MapNavigation?
    init(navigation: MapNavigation?, detail: DetailModel) {
        self.navigation = navigation
        self.detail = detail 
    }
    
    func dismissController() {
        navigation?.dismissController()
    }
    var chargerCount: Int {
        detail.charger.split(separator: ",").count
    }
    func goToRouteController(model: DetailModel) {
        navigation?.goToRoute(model: model)
    }
    
}
