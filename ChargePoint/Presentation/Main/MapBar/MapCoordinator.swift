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
        let controller = MapController(viewModel: .init(navigation: self) )
        showController(vc: controller)
    }
    
    
}
extension MapCoordinator: MapNavigation {
    func goToRoute(model: DetailModel) {
        if navigationController.presentedViewController is RouteController {return}
        let controller = RouteController(viewModel: .init(navigation: self, detail: model))
        if let presentedVC = navigationController.presentedViewController {
            presentedVC.dismiss(animated: false) { [weak self] in
                controller.modalPresentationStyle = .custom
                controller.hidesBottomBarWhenPushed = true
                self?.navigationController.present(controller, animated: true, completion: nil)
            }
        } else {
            controller.modalPresentationStyle = .custom
            controller.hidesBottomBarWhenPushed = true
            navigationController.present(controller, animated: true)
        }
    }

  
    func goToDetail(with model: DetailModel) {
        let controller = DetailController(viewModel: .init(navigation: self, detail: model))
        controller.modalPresentationStyle = .custom
        controller.hidesBottomBarWhenPushed = true
        navigationController.present(controller, animated: true)
    }

    func dismissController() {
        navigationController.dismiss(animated: true)
    }
    func openGoogleMap(lat: Double, lon: Double) {
        let googleMapsURL = URL(string: "comgooglemaps://?saddr=&daddr=\(lat),\(lon)&directionsmode=driving")!
        if UIApplication.shared.canOpenURL(googleMapsURL) {
            UIApplication.shared.open(googleMapsURL, options: [:], completionHandler: nil)
        } else {
            let webURL = URL(string: "https://www.google.com/maps/dir/?api=1&destination=\(lat),\(lon)&travelmode=driving")!
            UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
        }
    }
    
    func openWaze(lat: Double, lon: Double) {
        let wazeURL = URL(string: "waze://?ll=\(lat),\(lon)&navigate=yes")!
            if UIApplication.shared.canOpenURL(wazeURL) {
                UIApplication.shared.open(wazeURL, options: [:], completionHandler: nil)
            } else {
                let appStoreURL = URL(string: "https://apps.apple.com/app/waze-navigation-live-traffic/id323229106")!
                UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
    }
    }
    func openAppleMap(lat: Double, lon: Double) {
            let appleMapsURL = URL(string: "http://maps.apple.com/?daddr=\(lat),\(lon)&dirflg=d")!
            UIApplication.shared.open(appleMapsURL, options: [:], completionHandler: nil)
        }
}
    
