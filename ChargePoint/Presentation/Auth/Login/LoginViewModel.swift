//
//  LoginViewModel.swift
//  ChargePoint
//
//  Created by Javidan on 08.02.25.
//

import Foundation
final class LoginViewModel {
    
    enum ViewState {
        case loading
        case loaded
        case success
        case error(String)
    }
    
    var callback: ((ViewState)->Void)?
    
    private weak var navigation: AuthNavigation?
    
    init(navigation: AuthNavigation) {
        self.navigation = navigation
    }
    
    func registerWithEmail() {
        navigation?.goRegister()
    }
}
