//
//  SecondInfoViewModel.swift
//  ChargePoint
//
//  Created by Javidan on 07.02.25.
//

import Foundation

final class SecondInfoViewModel {
    
    private weak var navigation: IntroNavigation?
    init(navigation: IntroNavigation) {
        self.navigation = navigation
    }
    
    func goToAuth() {
        navigation?.goAuth()
    }
    
}
