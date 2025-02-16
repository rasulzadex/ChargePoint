//
//  AuthCoordinator.swift
//  ChargePoint
//
//  Created by Javidan on 01.02.25.
//

import Foundation
import UIKit.UINavigationController

final class AuthCoordinator: Coordinator {
    var parentCoordinator: (any Coordinator)?
    
    var children: [any Coordinator] = []
    
    var navigationController: UINavigationController
        
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = LoginController(viewModel: .init(navigation: self))
        showController(vc: controller)
    }
    
}

extension AuthCoordinator: AuthNavigation {
    func goRegister() {
        let controller = RegisterController(viewModel: .init(navigation: self))
        showController(vc: controller)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
    func goHome() {
        //
    }
    
   
}
