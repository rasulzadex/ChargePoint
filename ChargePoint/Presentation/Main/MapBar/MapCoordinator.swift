//
//  MapCoordinator.swift
//  ChargePoint
//
//  Created by Javidan on 16.02.25.
//

import Foundation
import UIKit.UINavigationController

final class MapCoordinator: Coordinator {
    var parentCoordinator: (any Coordinator)?
    
    var children: [any Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = MapController()
        showController(vc: controller)
    }
    
    
}

