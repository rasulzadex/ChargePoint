//
//  DetailController.swift
//  ChargePoint
//
//  Created by Javidan on 17.02.25.
//

import UIKit

class DetailController: BaseController {
    private let viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private lazy var infoImage: ReusableImage = {
        let i = ReusableImage(imageName: "detailLabel", contentMode: .scaleAspectFit)
        return i
    }()
    private lazy var blackView: UIView = {
        let v = UIView()
        v.backgroundColor = .black.withAlphaComponent(0)
        v.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        v.addGestureRecognizer(gesture)
        return v
    }()
    private lazy var backview: UIView = {
        let v = UIView()
        v.backgroundColor = .black.withAlphaComponent(0)
        return v
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.01) {
            self.transitionFlipFromLeft()
        }
    }
   
    @objc private func dismissController() {
        transitionFlipFromRight()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.55){
            self.viewModel.dismissController()}
    }
    private func transitionFlipFromLeft() {
        UIView.transition(with: infoImage, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    private func transitionFlipFromRight() {
        UIView.transition(with: infoImage, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
    }
    override func configureView() {
        super.configureView()
        view.addViews(view: [blackView, backview, infoImage])
    }
    override func configureConstraints() {
        super.configureConstraints()
        blackView.fillSuperview()
        infoImage.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 88, leading: 64, bottom: -228, trailing: -64)
        )
        backview.anchor(
            top: infoImage.topAnchor,
            leading: infoImage.leadingAnchor,
            bottom: infoImage.bottomAnchor,
            trailing: infoImage.trailingAnchor
        )
    }
}
