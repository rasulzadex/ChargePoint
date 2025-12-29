//
//  RegisterViewModel.swift
//  ChargePoint
//
//  Created by Javidan on 10.02.25.
//

import Foundation

enum RegisterViewState: BaseViewStateProtocol {
    case loading
    case loaded
    case success
    case error(String)
    case fieldError(ValidationType)
    case fieldValid(ValidationType)
}

enum ValidationType {
    case email , password
}

final class RegisterViewModel: BaseViewModel<RegisterViewState> {
    
    private var check: [ValidationType: Bool] = [
        .password: false,
        .email: false,
    ]
    var isAllValid: Bool {
        return check.values.contains(false)
    }
    
    private weak var navigation: AuthNavigation?
    
    init(navigation: AuthNavigation) {
        self.navigation = navigation
    }
    func popToLogin() {
        navigation?.pop()
    }
    func valueValidationType (value: String , type: ValidationType) -> Bool {
        
        let isValid: Bool
        switch type {
        case .email:
            isValid = value.isValidEmail()
        case .password:
            isValid = value.isValidPass()
        }
        check[type] = isValid
        if isValid {
            setState(state: .fieldValid(type))
        } else {
            setState(state: .fieldError(type))
        }
        
        return isValid
    }
}
