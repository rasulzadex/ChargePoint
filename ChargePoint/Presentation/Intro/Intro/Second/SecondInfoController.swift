//
//  SecondInfoController.swift
//  ChargePoint
//
//  Created by Javidan on 06.02.25.
//

import UIKit

final class SecondInfoController: BaseController {

    private let viewModel: SecondInfoViewModel
    init(viewModel: SecondInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var getStartedImage: ReusableImage = {
        let i = ReusableImage(imageName: "logo", contentMode: .scaleAspectFit)
        return i
    }()
    
    private lazy var getStartedLabel: ReusableLabel = {
        let l = ReusableLabel(text: "Tətbiq elektromobil sürücüləri üçün ölkədə enerji doldurma prosesini daha sürətli, əlçatan və rahat etmək məqsədilə hazırlanıb. İndi başlayın və yolunuzu enerjisiz qoymayın!", textAlignment: .left, fontName: "Arch", fontSize: 18, textColor: .white, numberOfLines: 0)
        return l
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
        let l = ReusableLabel(text: "◉ Yaxınlıqdakı enerji məntəqələrini xəritədə tapın – Tətbiq sizin yerinizi avtomatik təyin edərək, sizə ən yaxın və əlverişli stansiyaları göstərir.", textAlignment: .left, fontName: "Arch", fontSize: 18, textColor: .white, numberOfLines: 0)
        return l
    }()
    private lazy var secondInfoLabel: ReusableLabel = {
        let l = ReusableLabel(text: "◉ Real vaxt rejimində doluluq və aktivlik statusunu yoxlayın – Stansiyanın dolu olub-olmadığını əvvəlcədən bilmək vaxtınıza qənaət etməyə kömək edəcək.", textAlignment: .left, fontName: "Arch", fontSize: 18, textColor: .white, numberOfLines: 0)
        return l
    }()
    
    private lazy var getStartedName: ReusableImage = {
        let i = ReusableImage(imageName: "chargePoint", contentMode: .scaleAspectFit)
        return i
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
        UserDefaultsHelper.setInteger(key: UserDefaultsKey.loginType.rawValue, value: 0)
    }
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.flipImageHorizontally()}
    }
    

    @objc private func getStartedClick() {
        flipImageHorizontally()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.viewModel.goToAuth() }
    }
    override func configureView() {
        view.addViews(view: [
            getStartedImage,
            getStartedName,
            getStartedLabel,
            infoStack,
            nextIcon
        ])
    }
    
    override func configureConstraints() {
        firstInfoLabel.anchorSize(CGSize(width: 0, height: infoStack.frame.height/2))
        getStartedImage.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
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
        getStartedLabel.anchor(
            top: getStartedName.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(all: 24)
        )
        infoStack.anchor(
            top: getStartedLabel.bottomAnchor,
            leading: getStartedLabel.leadingAnchor,
            trailing: getStartedLabel.trailingAnchor,
            padding: .init(top: 16, leading: 12, trailing: -12)
        )

        nextIcon.anchor(
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(bottom: -24,  trailing: -36)
        )
        nextIcon.anchorSize(CGSize(width: view.frame.width/6, height: view.frame.width/6))
    }
    
    private func flipImageHorizontally() {
        UIView.transition(with: getStartedImage, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }

    
        
}

