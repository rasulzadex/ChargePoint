//
//  LoginController.swift
//  ChargePoint
//
//  Created by Javidan on 07.02.25.
//

import UIKit

final class LoginController: BaseController {

    private let viewModel: LoginViewModel
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var logo: ReusableImage = {
        let i = ReusableImage(imageName: "logo", contentMode: .scaleAspectFit)
        return i
    }()
    private lazy var mailLabel: ReusableLabel = {
        let l = ReusableLabel(text: " Email ", textAlignment: .left, fontName: "Arch", fontSize: 16, textColor: .evTurquoise, numberOfLines: 0, cornerRadius: 0)
        l.backgroundColor = .evBlue
        return l
    }()
    private lazy var mailField: ReusableTextField = {
        let t = ReusableTextField(placeholder: "example@example.com", placeholderColor: .white.withAlphaComponent(0.5), borderColor: .evTurquoise, texttColor: .white, bgColor: .evBlue)
        t.layer.cornerRadius = 15
        t.setLeftPadding(20)
        return t
    }()
    private lazy var passLabel: ReusableLabel = {
        let l = ReusableLabel(text: " Şifrə ", textAlignment: .left, fontName: "Arch", fontSize: 16, textColor: .evTurquoise, numberOfLines: 0, cornerRadius: 0)
        l.backgroundColor = .evBlue
        return l
    }()
    private lazy var passField: ReusableTextField = {
        let t = ReusableTextField(placeholder: "*********", placeholderColor: .white.withAlphaComponent(0.5), borderColor: .evTurquoise, texttColor: .white, bgColor: .evBlue)
        t.setLeftPadding(20)
        t.layer.cornerRadius = 15
        t.isSecureTextEntry = true
        return t
    }()
    private lazy var loginButton: ReusableButton = {
        let b = ReusableButton(title: "Daxil ol", buttonColor: .evDarkGreen) {
            [weak self] in self?.loginAction()
        }
        b.titleLabel?.font =  UIFont(name: "Arch", size: 20)
        return b
    }()
    private lazy var toggleButton: ReusableButton = {
        let b = ReusableButton(title: "", buttonColor: .clear) {
            [weak self] in self?.toggleSecureTextEntry()
        }
        b.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        b.tintColor = .evTurquoise
        return b
    }()
    private lazy var registerLabel: ReusableLabel = {
        let l = ReusableLabel(text: "ChargePoint hesabın yoxdur?", textAlignment: .center, fontName: "Arch", fontSize: 20, textColor: .white, numberOfLines: 0, cornerRadius: 0)
        return l
    }()
    private lazy var googleButton: ReusableButton = {
        let b = ReusableButton(title: "Google ilə davam et", buttonColor: .white) {
            [weak self] in self?.loginAction()
        }
        b.titleLabel?.font =  UIFont(name: "Arch", size: 20)
        b.setTitleColor(.evDarkGreen, for: .normal)
        return b
    }()
    private lazy var googleIcon: ReusableImage = {
        let i = ReusableImage(imageName: "google", contentMode: .scaleAspectFit)
        return i
    }()
    private lazy var registerButton: ReusableButton = {
        let b = ReusableButton(title: "Email ilə davam et", buttonColor: .evSea) {
            [weak self] in self?.mailRegisterClick()
        }
        b.titleLabel?.font =  UIFont(name: "Arch", size: 20)
        b.setTitleColor(.white, for: .normal)
        return b
    }()
    private lazy var mailIcon: ReusableImage = {
        let i = ReusableImage(imageName: "mail", contentMode: .scaleAspectFit)
        i.tintColor = .white
        return i
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @objc private func loginAction() {
        print(#function)
    }
    @objc private func mailRegisterClick() {
        viewModel.registerWithEmail()
    }
    @objc private func toggleSecureTextEntry() {
            passField.isSecureTextEntry.toggle()
            let imageName = passField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
            toggleButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
    
    private func configureViewModel() {
        viewModel.callback = {[weak self] state in
            guard let self else {return}
            switch state {
            case .loading:
                print(#function)
            case .loaded:
                print(#function)
            case .success:
                print(#function)
            case .error(_):
                print(#function)
            }
        }
        }
    
    override func configureView() {
        super.configureView()
        view.addViews(view: [logo,mailField, mailLabel, passField, passLabel, toggleButton, loginButton, registerLabel, googleButton, googleIcon, registerButton, mailIcon])
    }
    override func configureConstraints() {
        super.configureConstraints()
        logo.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 12, leading: 36, trailing: -36)
        )
        logo.anchorSize(CGSize(width: 0, height: view.frame.height/4))
        mailLabel.anchor(
            leading: mailField.leadingAnchor,
            bottom: mailField.topAnchor,
            padding: .init(leading: 24, bottom: 12)
        )
        mailLabel.anchorSize(CGSize(width: mailField.frame.width/4, height: mailField.frame.height/2))
        mailField.anchor(
            top: logo.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(all: 36)
        )
        mailField.anchorSize(CGSize(width: 0, height: 52))
        passLabel.anchor(
            leading: passField.leadingAnchor,
            bottom: passField.topAnchor,
            padding: .init(leading: 24, bottom: 12)
        )
        passLabel.anchorSize(CGSize(width: mailField.frame.width/4, height: mailField.frame.height/2))
        passField.anchor(
            top: mailField.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 36, leading: 36, trailing: -36)
        )
        toggleButton.anchor(
            top: passField.topAnchor,
            bottom: passField.bottomAnchor,
            trailing: passField.trailingAnchor,
            padding: .init(all: 12)
        )
        passField.anchorSize(CGSize(width: 0, height: 52))
        loginButton.anchor(
            top: passField.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(all: 36)
        )
        loginButton.anchorSize(CGSize(width: 0, height: 52))
        registerLabel.anchor(
            top: loginButton.bottomAnchor,
            leading: loginButton.leadingAnchor,
            trailing: loginButton.trailingAnchor,
            padding: .init(top: 24, leading: 12, trailing: -12)
        )
        googleButton.anchor(
            top: registerLabel.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 12, leading: 36, trailing: -36)
        )
        googleButton.anchorSize(CGSize(width: 0, height: 52))
        googleIcon.anchor(
            top: googleButton.topAnchor,
            leading: googleButton.leadingAnchor,
            bottom: googleButton.bottomAnchor,
            padding: .init(top: 8, leading: 24, bottom: -8)
        )
        googleIcon.anchorSize(CGSize(width: 24, height: 0))
        registerButton.anchor(
            top: googleButton.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 12, leading: 36, trailing: -36)
        )
        registerButton.anchorSize(CGSize(width: 0, height: 52))
        mailIcon.anchor(
            top: registerButton.topAnchor,
            leading: registerButton.leadingAnchor,
            bottom: registerButton.bottomAnchor,
            padding: .init(top: 8, leading: 24, bottom: -8)
        )
        mailIcon.anchorSize(CGSize(width: 24, height: 0))
    }
    
    }
    
extension LoginController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let text = textField.text
        print(text)
    }
}
