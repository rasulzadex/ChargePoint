//
//  RegisterController.swift
//  ChargePoint
//
//  Created by Javidan on 08.02.25.
//

import UIKit

final class RegisterController: BaseController {
    private let viewModel: RegisterViewModel
    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private var ValidationMapping: [UITextField: RegisterViewModel.ValidationType] = [:]

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
        t.delegate = self
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
        t.delegate = self
        t.isSecureTextEntry = true
        return t
    }()
    private lazy var registerButton: ReusableButton = {
        let b = ReusableButton(title: "Qeydiyyatdan keç", buttonColor: .evDarkGreen) {
            [weak self] in self?.mailRegisterClick()
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
        let l = ReusableLabel(text: "ChargePoint hesabın var?", textAlignment: .left, fontName: "Arch", fontSize: 20, textColor: .white, numberOfLines: 0, cornerRadius: 0)
        return l
    }()
    private lazy var loginButton: ReusableButton = {
        let b = ReusableButton(title: "Daxil ol", buttonColor: .clear) {
            [weak self] in self?.loginAction()
        }
        b.titleLabel?.font =  UIFont(name: "Arch", size: 20)
        b.setTitleColor(.linkBlue, for: .normal)
        return b
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapping()
        
    }
    @objc private func loginAction() {
        viewModel.popToLogin()
    }
    @objc private func mailRegisterClick() {
        checkValidation()
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
            default: break
            }
        }
        }
    func setupMapping(){
        ValidationMapping = [
            mailField: .email,
            passField: .password,
            
        ]
    }
    
    private func checkValidation() {
        let fields: [(UITextField, RegisterViewModel.ValidationType)] = [
            (mailField, .email),
            (passField, .password)
        ]
        var isValid = true
        for (textField, validationType) in fields {
            guard let text = textField.text, !text.isEmpty else {
                textField.layer.borderColor = UIColor.red.cgColor
                isValid = false
                continue
            }
            if viewModel.valueValidationType(value: text, type: validationType) {
                textField.layer.borderColor = UIColor.green.cgColor
            } else {
                textField.layer.borderColor = UIColor.red.cgColor
                isValid = false
            }
        }
        if !isValid {
            showAlert(title: "Error", message: "Please fix the errors in the highlighted fields.")
            return
        }
        guard let email = mailField.text,
              let pass = passField.text else { return }
            print("Melumatlar duzdur")
    }
    
    override func configureView() {
        super.configureView()
        view.addViews(view: [logo,mailField, mailLabel, passField, passLabel, toggleButton, loginButton, registerLabel, registerButton])
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        logo.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 52, leading: 36, trailing: -36)
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
        registerButton.anchor(
            top: passField.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(all: 36)
        )
        registerButton.anchorSize(CGSize(width: 0, height: 52))
        registerLabel.anchor(
            top: registerButton.bottomAnchor,
            leading: registerButton.leadingAnchor,
            padding: .init(top: 24, leading: 24)
        )
        loginButton.anchor(
            top: registerLabel.topAnchor,
            leading: registerLabel.trailingAnchor,
            bottom: registerLabel.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, leading: 0, bottom: 0, trailing: -60)
        )
    }
    
    }
    
extension RegisterController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let validationType = ValidationMapping[textField] else { return }
        let isValid = viewModel.valueValidationType(value: textField.text ?? "", type: validationType)
        textField.layer.borderColor = isValid ? UIColor.green.cgColor : UIColor.red.cgColor

    }
}


