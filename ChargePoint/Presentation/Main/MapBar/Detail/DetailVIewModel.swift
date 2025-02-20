//
//  DetailVIewModel.swift
//  ChargePoint
//
//  Created by Javidan on 18.02.25.
//

import Foundation
final class DetailViewModel {
    
    private weak var navigation: MapNavigation?
    init(navigation: MapNavigation?) {
        self.navigation = navigation
    }
    
    func dismissController() {
        navigation?.dismissController()
    }
}
