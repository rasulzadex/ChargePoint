//
//  ProfileController.swift
//  ChargePoint
//
//  Created by Javidan on 16.02.25.
//

import UIKit

final class ProfileController: BaseController {

    private lazy var infoImage: ReusableImage = {
        let i = ReusableImage(imageName: "infoImage", contentMode: .scaleAspectFill)
        return i
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func configureView() {
        super.configureView()
        view.addViews(view: [infoImage])
    }
    override func configureConstraints() {
        super.configureConstraints()
        infoImage.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(all: 40)
        )
    }

}
