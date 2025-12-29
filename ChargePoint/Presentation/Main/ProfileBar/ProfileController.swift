//
//  ProfileController.swift
//  ChargePoint
//
//  Created by Javidan on 16.02.25.
//

import UIKit
import Foundation

final class ProfileController: BaseViewController<ProfileViewModel> {

    private lazy var infoImage: ReusableImage = {
        let i = ReusableImage(imageName: "infoImage", contentMode: .scaleAspectFill)
        return i
    }()
    
    override init(viewModel: ProfileViewModel) {
        super.init(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureView() {
        super.configureView()
        view.addViews(view: [infoImage])
    }
    override func configureAnchors() {
        super.configureAnchors()
        infoImage.fillSuperview(padding: .init(all: 40))
//        infoImage.anchor(
//            top: view.safeAreaLayoutGuide.topAnchor,
//            leading: view.leadingAnchor,
//            bottom: view.bottomAnchor,
//            trailing: view.trailingAnchor,
//            padding: .init(all: 40)
//        )
    }

}
