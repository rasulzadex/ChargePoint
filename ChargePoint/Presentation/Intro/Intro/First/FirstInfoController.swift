//
//  FirstInfoController.swift
//  ChargePoint
//
//  Created by Javidan on 03.02.25.
//

import UIKit

final class FirstInfoController: BaseController {

    private let viewModel: FirstInfoViewModel
    init(viewModel: FirstInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var getStartedImage: ReusableImage = {
        let i = ReusableImage(imageName: "evCar", contentMode: .scaleAspectFit)
        return i
    }()
    
    private lazy var infoStack  : UIStackView = {
        let s = UIStackView(arrangedSubviews: [firstInfoLabel, secondInfoLabel])
        s.alignment = .fill
        s.distribution = .fill
        s.axis = .vertical
        s.spacing = 4
        return s
    }()
    private lazy var firstInfoLabel: ReusableLabel = {
        let l = ReusableLabel(text: "Ölkəmizdə müxtəlif şirkətlərə məxsus elektromobil enerji doldurma məntəqələrini vahid platformada birləşdirərək sürücülərə daha rahat və effektiv enerji doldurma imkanı təqdim edir.", textAlignment: .left, fontName: "Arch", fontSize: 20, textColor: .white, numberOfLines: 0)
        return l
    }()
    private lazy var secondInfoLabel: ReusableLabel = {
        let l = ReusableLabel(text: "Artıq fərqli operatorların stansiyalarını ayrıca axtarmağa ehtiyac qalmadan, bir tətbiq vasitəsilə bütün mövcud məntəqələrə çıxış əldə edə biləcəksiniz.", textAlignment: .left, fontName: "Arch", fontSize: 20, textColor: .white, numberOfLines: 0)
        return l
    }()
    
    
    
    private lazy var getStartedName: ReusableImage = {
        let i = ReusableImage(imageName: "chargePoint", contentMode: .scaleAspectFit)
        return i
    }()
    private lazy var welcomLabel: ReusableLabel = {
        let l = ReusableLabel(text: "Xoş gəlmişsiniz!", textAlignment: .left, fontName: "AmericanCaptain", fontSize: 48, textColor: .white, numberOfLines: 0)
        return l
    }()

    private lazy var nextIcon: ReusableImage = {
        let i = ReusableImage(imageName: "nextIcon", contentMode: .scaleAspectFit, cornerRadius: 20)
        i.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(getStartedClick))
        i.addGestureRecognizer(gestureRecognizer)
        return i
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .evBlue
        UserDefaultsHelper.setInteger(key: UserDefaultsKey.loginType.rawValue, value: 0)

    }
         
    @objc private func getStartedClick() {
        viewModel.goToSecondInfo()
        print(#function)
    }
    override func configureView() {
        view.addViews(view: [
            welcomLabel,
            getStartedImage,
            getStartedName,
            infoStack,
            nextIcon
        ])
    }
    
    override func configureConstraints() {
        welcomLabel.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 24, leading: 36, trailing: -36)
        )
        getStartedImage.anchor(
            top: welcomLabel.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 24, leading: 0, trailing: 0)
        )
        getStartedImage.anchorSize(CGSize(width: 0, height: view.frame.height/4))
        getStartedName.anchor(
            top: getStartedImage.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 24, leading: 36, trailing: -36)
        )
        getStartedName.anchorSize(CGSize(width: 0, height: view.frame.height/15))
        infoStack.anchor(
            top: getStartedName.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(all: 24)
        )
        firstInfoLabel.anchorSize(CGSize(width: 0, height: infoStack.frame.height/2))

        nextIcon.anchor(
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(bottom: -24,  trailing: -36)
        )
        nextIcon.anchorSize(CGSize(width: view.frame.width/6, height: view.frame.width/6))
    }
        
}

