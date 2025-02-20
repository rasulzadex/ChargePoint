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
        let controller = MapController(viewModel: .init(navigation: self))
        showController(vc: controller)
    }
    
    
}
extension MapCoordinator: MapNavigation {
    func dismissController() {
        navigationController.dismiss(animated: true)
    }
    
    func goDetail() {
        let controller = DetailController(viewModel: .init(navigation: self))
        controller.modalPresentationStyle = .custom
        controller.hidesBottomBarWhenPushed = true
        navigationController.present(controller, animated: true)    }
}
