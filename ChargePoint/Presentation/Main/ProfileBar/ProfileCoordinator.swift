//
//  ProfileCoordinator.swift
//  ChargePoint
//
//  Created by Javidan on 16.02.25.
//

import Foundation
import UIKit.UINavigationController

final class ProfileCoordinator: Coordinator {
    var parentCoordinator: (any Coordinator)?
    
    var children: [any Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = ProfileController()
        showController(vc: controller)
    }
    
    
}
