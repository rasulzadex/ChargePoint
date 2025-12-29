//
//  LoginViewModel.swift
//  ChargePoint
//
//  Created by Javidan on 08.02.25.
//

import Foundation
final class LoginViewModel: BaseViewModel<BaseViewState> {
    
    private weak var navigation: AuthNavigation?
    
    init(navigation: AuthNavigation) {
        self.navigation = navigation
    }
    
    func registerWithEmail() {
        navigation?.goRegister()
    }
    func goHome(){
        navigation?.goHome()
    }
}
