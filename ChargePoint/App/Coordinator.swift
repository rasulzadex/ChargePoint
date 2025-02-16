//
//  Coordinator.swift
//  ChargePoint
//
//  Created by Javidan on 01.02.25.
//

import Foundation
import UIKit.UINavigationController
import SafariServices

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? {get set}
    var children: [Coordinator]  {get set}
    var navigationController: UINavigationController {get set}
    func start()
}


extension Coordinator {
    
    func childDidFinish(_ coordinator: Coordinator) {
        for (index, child) in children.enumerated() {
            if child === coordinator {
                children.remove(at: index)
                break
            }
        }
    }
    func showController(vc: UIViewController) {
        navigationController.show(vc, sender: nil)
    }
    
    
//    func goToWebPage(with urlString: String) {
//        guard let url = URL(string: urlString) else {return}
//        let controller = SFSafariViewController(url: url )
//        navigationController.present(controller, animated: true)
//    }
}
