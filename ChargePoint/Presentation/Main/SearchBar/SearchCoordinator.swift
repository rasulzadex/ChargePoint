//
//  SearchCoordinator.swift
//  ChargePoint
//
//  Created by Javidan on 16.02.25.
//

import Foundation
import UIKit.UINavigationController

final class SearchCoordinator: Coordinator {
    var parentCoordinator: (any Coordinator)?
    
    var children: [any Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = SearchController(viewModel: .init(navigation: navigationController as? SearchNavigation) )
        navigationController.isNavigationBarHidden = false
        showController(vc: controller)
    }
    
    
}
extension SearchCoordinator: SearchNavigation {
    func openDetail() {
        print(#function)
    }
}
