//
//  RouteController.swift
//  ChargePoint
//
//  Created by Javidan on 27.02.25.
//

import UIKit

class RouteController: BaseController {

    let viewModel: RouteViewModel
    init(viewModel: RouteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private lazy var blackView: UIView = {
        let v = UIView()
        v.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        v.addGestureRecognizer(gesture)
        return v
    }()
    private lazy var routeLabel: ReusableImage = {
        let l = ReusableImage(imageName: "routeLabel", contentMode: .scaleAspectFit)
        return l
    }()
    private lazy var wazeIcon: ReusableImage = {
        let l = ReusableImage(imageName: "wazeMap", contentMode: .scaleAspectFit)
        l.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openWaze))
        l.addGestureRecognizer(gesture)
        return l
    }()
    private lazy var googlemapIcon: ReusableImage = {
        let l = ReusableImage(imageName: "googleMap", contentMode: .scaleAspectFit)
        l.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openGoogleMap))
        l.addGestureRecognizer(gesture)
        return l
    }()
    private lazy var applemapIcon: ReusableImage = {
        let l = ReusableImage(imageName: "appleMap", contentMode: .scaleAspectFit)
        l.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openGoogleMap))
        l.addGestureRecognizer(gesture)
        return l
    }()
    private lazy var stackView: ReusableStackView = {
        let s = ReusableStackView(
            arrangedSubviews: [wazeIcon, applemapIcon, googlemapIcon],
            alignment: .fill,
            distribution: .fillEqually,
            axis: .horizontal,
            spacing: 20
        )
        return s
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.blackView.backgroundColor = .black.withAlphaComponent(0.6)
        }
    }
    @objc private func dismissController() {
        blackView.alpha = 0
        viewModel.dismissController()
    }
    @objc private func openWaze() {
        viewModel.openWaze()
    }
    @objc private func openGoogleMap() {
        print(#function)
        viewModel.openGoogleMaps()
    }
    @objc private func openAppleMaps() {
        viewModel.openAppleMaps()
    }
    override func configureView() {
        view.backgroundColor = .clear
        view.addViews(view: [blackView, routeLabel, stackView])
    }
    
    override func configureConstraints() {
        blackView.fillSuperview()
        routeLabel.anchor(
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(all: 0)
        )
        routeLabel.anchorSize(CGSize(width: 0, height: view.frame.height*0.2))
        stackView.anchor(
            top: routeLabel.topAnchor,
            leading: routeLabel.leadingAnchor,
            trailing: routeLabel.trailingAnchor,
            padding: .init(top: 36, leading: 24, trailing: -24)
        )
        stackView.anchorSize(CGSize(width: 0, height: view.frame.height*0.1))
    }


}
