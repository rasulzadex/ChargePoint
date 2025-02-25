//
//  DetailController.swift
//  ChargePoint
//
//  Created by Javidan on 17.02.25.
//

import UIKit

final class DetailController: BaseController {
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
    private lazy var locationIcon: ReusableImage = {
        let i = ReusableImage(imageName: "target", contentMode: .scaleAspectFit)
        i.tintColor = .evNavigation
        return i
    }()
    private lazy var locationLabel: ReusableLabel = {
        let l = ReusableLabel(text: "Respublika Velotreki V2 - 120 kW", textAlignment: .left, fontName: "Arch", fontSize: 14, textColor: .black, numberOfLines: 0)
        l.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return l
    }()
    private lazy var addressIcon: ReusableImage = {
        let i = ReusableImage(imageName: "address", contentMode: .scaleAspectFit)
        i.tintColor = .evNavigation
        return i
    }()
    private lazy var addressLabel: ReusableLabel = {
        let l = ReusableLabel(text: "Rövşən Cəfərov 10, Bakı", textAlignment: .left, fontName: "Arch", fontSize: 14, textColor: .black, numberOfLines: 0)
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return l
    }()
    private lazy var timeIcon: ReusableImage = {
        let i = ReusableImage(imageName: "time", contentMode: .scaleAspectFit)
        i.tintColor = .evNavigation
        return i
    }()
    private lazy var timeLabel: ReusableLabel = {
        let l = ReusableLabel(text: "İşləmə saatı - 24/7", textAlignment: .left, fontName: "Arch", fontSize: 14, textColor: .black, numberOfLines: 0)
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return l
    }()
    private lazy var locationStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [locationIcon, locationLabel])
        s.alignment = .fill
        s.distribution = .fill
        s.axis = .horizontal
        s.spacing = 6
        return s
    }()
    private lazy var timeStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [timeIcon, timeLabel])
        s.alignment = .fill
        s.distribution = .fill
        s.axis = .horizontal
        s.spacing = 6
        return s
    }()
    private lazy var addressStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [addressIcon, addressLabel])
        s.alignment = .fill
        s.distribution = .fill
        s.axis = .horizontal
        s.spacing = 6
        return s
    }()
    private lazy var totalStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [locationStack, addressStack, timeStack])
        s.alignment = .fill
        s.distribution = .fillProportionally
        s.axis = .vertical
        s.spacing = 0
        return s
    }()
    private lazy var blackView: UIView = {
        let v = UIView()
        v.backgroundColor = .black.withAlphaComponent(0.5)
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
    
    private lazy var navigationButton: ReusableButton = {
        let b = ReusableButton(title: "Naviqasiya et", buttonColor: .evNavigation) {
            [weak self] in self?.goNavigateClick()
        }
        return b
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
            self.viewModel.dismissController(
            )}
    }
    @objc private func goNavigateClick() {
        print(#function)
    }
    private func transitionFlipFromLeft() {
        UIView.transition(with: infoImage, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        UIView.transition(with: totalStack, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    private func transitionFlipFromRight() {
        UIView.transition(with: infoImage, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
        UIView.transition(with: totalStack, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    override func configureView() {
        super.configureView()
        view.addViews(view: [blackView, backview, infoImage, navigationButton, totalStack])
    }
    override func configureConstraints() {
        super.configureConstraints()
        blackView.fillSuperview()
        infoImage.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 108, leading: 64, bottom: -208, trailing: -64)
        )
        backview.anchor(
            top: infoImage.topAnchor,
            leading: infoImage.leadingAnchor,
            bottom: infoImage.bottomAnchor,
            trailing: infoImage.trailingAnchor
        )
        navigationButton.anchor(
            top: infoImage.bottomAnchor,
            leading: infoImage.leadingAnchor,
            trailing: infoImage.trailingAnchor,
            padding: .init(all: 12)
        )
        navigationButton.anchorSize(CGSize(width: 0, height: 48))
        totalStack.anchor(
            top: infoImage.topAnchor,
            leading: infoImage.leadingAnchor,
            trailing: infoImage.trailingAnchor,
            padding: .init(top: 100, leading: 28, trailing: -28)
        )
        totalStack.anchorSize(CGSize(width: 0, height: view.frame.height/8))
        locationIcon.anchorSize(CGSize(width: 25, height: 0))
        locationStack.anchorSize(CGSize(width: 0, height: 50))
        addressIcon.anchorSize(CGSize(width: 25, height: 0))
        timeIcon.anchorSize(CGSize(width: 25, height: 0))
    }
}
