//
//  MainTabBarController.swift
//  ChargePoint
//
//  Created by Javidan on 16.02.25.
//

import Foundation
import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupTabBar()

    }
    override func viewDidAppear(_ animated: Bool) {
        self.selectedIndex = 1
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        changeShape()
    }
    private func setupTabBar() {
        let customTabBar = MainTabBarView()
        self.setValue(customTabBar, forKey: "tabBar")
        self.tabBar.backgroundColor = .clear
    }
    private func changeShape() {
        if let tabbar = tabBar as? MainTabBarView {
            tabbar.addCurveToIndex()
        }
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    
}
