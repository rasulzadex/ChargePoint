//
//  AuthCoordinator.swift
//  ChargePoint
//
//  Created by Javidan on 01.02.25.
//

import Foundation
import UIKit.UINavigationController
//protocol AuthCoordinatorDelegate: AnyObject {
//    func didLogin()
//}


final class IntroCoordinator: Coordinator {
    var parentCoordinator: (any Coordinator)?
    
    var children: [any Coordinator] = []
    
    var navigationController: UINavigationController
        
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        goIntroduction()
    }
    
}

extension IntroCoordinator: IntroNavigation {
    func goAuth() {
        let coor = parentCoordinator as! AppCoordinator
        UserDefaultsHelper.setInteger(key: UserDefaultsKey.loginType.rawValue, value: 1)
        children.removeAll()
        coor.start()
    }
    
    func goIntroduction() {
        let controller = FirstInfoController(viewModel: .init(navigation: self))
        showController(vc: controller)
    }
    
    func goSecondIntro() {
        let controller = SecondInfoController(viewModel: .init(navigation: self))
        showController(vc: controller)
    }
}
