//
//  FirstInfoViewModel.swift
//  ChargePoint
//
//  Created by Javidan on 06.02.25.
//

import Foundation

final class FirstInfoViewModel {
    
    private weak var navigation: IntroNavigation?
    init(navigation: IntroNavigation) {
        self.navigation = navigation
    }
    
    func goToSecondInfo() {
        navigation?.goSecondIntro()
    }
    
}
