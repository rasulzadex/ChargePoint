//
//  MainTabbarCoordiantor.swift
//  ChargePoint
//
//  Created by Javidan on 16.02.25.
//



import Foundation
import UIKit.UINavigationController

final class MainTabBarCoordinator: Coordinator {
    var parentCoordinator: (any Coordinator)?
    var children: [any Coordinator] = []
    var navigationController: UINavigationController
    private let tabbarController = MainTabBarController()

    private var mapCoordinator: MapCoordinator?
    private var searchCoordinator: SearchCoordinator?
    private var profileCoordinator: ProfileCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        initializeTabBar()

    }
    
    private func initializeTabBar() {
        let mapNavigationController = UINavigationController()
        mapCoordinator = MapCoordinator(navigationController: mapNavigationController)
        mapCoordinator?.parentCoordinator = parentCoordinator
        
        let mapItem = UITabBarItem()
        mapItem.title = "Xəritə"
        mapItem.image = UIImage(systemName: "map")
        mapItem.selectedImage = UIImage(systemName: "map.circle.fill")?.resize(to: CGSize(width: 72, height: 72))
        mapNavigationController.tabBarItem = mapItem
        
                
        let profNavigationController = UINavigationController()
        profileCoordinator = ProfileCoordinator(navigationController: profNavigationController)
        profileCoordinator?.parentCoordinator = parentCoordinator
        
        let profileItem = UITabBarItem()
        profileItem.title = "Hesab"
        profileItem.image = UIImage(systemName: "person")
        profileItem.selectedImage = UIImage(systemName: "person.circle.fill")?.resize(to: CGSize(width: 72, height: 72))
        profNavigationController.tabBarItem = profileItem
        
        let searchNavigationController = UINavigationController()
        searchCoordinator = SearchCoordinator(navigationController: searchNavigationController)
        searchCoordinator?.parentCoordinator = parentCoordinator
        searchNavigationController.setNavigationBarHidden(true, animated: false)

        
        let searchItem = UITabBarItem()
        searchItem.title = "Axtar"
        searchItem.image = UIImage(systemName: "magnifyingglass")
        searchItem.selectedImage = UIImage(systemName: "magnifyingglass.circle.fill")?.resize(to: CGSize(width: 72, height: 72))
        searchNavigationController.tabBarItem = searchItem
        
        
        
        tabbarController.viewControllers = [
            searchNavigationController,
            mapNavigationController,
            profNavigationController
        ]
        
        
        navigationController.pushViewController(tabbarController, animated: true)
        
        parentCoordinator?.children.append(mapCoordinator ?? MapCoordinator(navigationController: navigationController))
        mapCoordinator?.start()
        
        parentCoordinator?.children.append(profileCoordinator ?? ProfileCoordinator(navigationController: UINavigationController()))
        profileCoordinator?.start()
        
        parentCoordinator?.children.append(searchCoordinator ?? SearchCoordinator(navigationController: UINavigationController()))
        searchCoordinator?.start()
        
    }
    
    
    
}
