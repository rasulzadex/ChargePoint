//
//  AppCoordinator.swift
//  ChargePoint
//
//  Created by Javidan on 01.02.25.
//

import Foundation
import UIKit.UINavigationController

final class AppCoordinator: Coordinator {
    var parentCoordinator: (any Coordinator)?
    var children: [any Coordinator] = []
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.navigationBar.tintColor = .evTurquoise
        navigationController.navigationItem.title = "Geri"
    }
    func start() {
        let loginType = UserDefaultsHelper.getInteger(key: UserDefaultsKey.loginType.rawValue)
        switch loginType {
        case 0:
            showIntro()
        case 1:
            showAuth()
        case 2:
            showHome()
        default: return
        }

    }
    fileprivate func showIntro() {
        children.removeAll()
        navigationController.viewControllers = []
        let auth = IntroCoordinator(navigationController: navigationController)
        children.append(auth)
        navigationController.isNavigationBarHidden = true
        auth.parentCoordinator = self
        auth.start()
    }
    fileprivate func showAuth() {
        children.removeAll()
        navigationController.viewControllers = []
        let auth = AuthCoordinator(navigationController: navigationController)
        children.append(auth)
        navigationController.isNavigationBarHidden = false
        navigationController.navigationItem.leftBarButtonItem?.title = "Geri"
        auth.parentCoordinator = self
        auth.start()
    }
     fileprivate func showHome() {
         children.removeAll()
         navigationController.viewControllers = []
         let mainTabbar = MainTabBarCoordinator(navigationController: navigationController)
            children.append(mainTabbar)
         mainTabbar.parentCoordinator = self
         mainTabbar.start()
 
     }
}

