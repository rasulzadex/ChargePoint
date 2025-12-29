//
//  BaseViewController.swift
//  ChargePoint
//
//  Created by Javidan on 01.02.25.

import UIKit

open class BaseViewController<ViewModel: BaseViewModelProtocol>: UIViewController {
    
    public var viewModel: ViewModel
    public var transformableView: [UIView]?
    open var keyboardOffsetAdjustment: CGFloat { 8 }
    
    private let loadingView: BaseLoadingView = {
        let view = BaseLoadingView(style: .fullscreen())
        view.isHidden = true
        return view
    }()
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureBindings()
        configureView()
        configureAnchors()
        configureTargets()
        configureLoadingView()
    }
    
    open func configureBindings() {
        viewModel.onStateChange = { [weak self] state in
            self?.render(state: state)
        }
    }
    
    open func configureView() {
        // Default empty implementation
    }
    open func configureAnchors() {
        // Default empty implementation
    }
    open func configureTargets() {
        // Default empty implementation
    }
    
    open func render(state: ViewModel.StateType) {
        // Can be overridden by subclasses to handle state-specific rendering
    }
    
    private func configureLoadingView() {
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    open func updateUIWhenKeyboardWillShow(offset: CGFloat) {}
    open func updateUIWhenKeyboardWillHide() {
        // Default empty implementation
    }
    open func appWillEnterForeground() {
        // Default empty implementation
    }
    
    // MARK: - Keyboard Notifications
    
    public func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChangeFrame(notification:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appWillForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }
    
    public func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    public func startLoading() {
        view.bringSubviewToFront(loadingView)
        loadingView.isHidden = false
        loadingView.start()
    }
    
    public func stopLoading() {
        loadingView.stop()
        loadingView.isHidden = true
    }
    
    // MARK: - Keyboard Handling
    
    open func keyboardWillHide() {}
    
    @objc
    private func keyboardWillShow(notification: Notification) {
        adjustForKeyboard(notification: notification)
    }
    
    @objc
    private func keyboardWillChangeFrame(notification: Notification) {
        adjustForKeyboard(notification: notification)
    }
    
    @objc
    private func keyboardWillHide(notification: Notification) {
        resetTransformableViews()
        keyboardWillHide()
        updateUIWhenKeyboardWillHide()
    }
    
    @objc
    private func appWillForeground() {
        appWillEnterForeground()
    }
    
    private func adjustForKeyboard(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        let bottomPadding = windowSafeAreaBottomPadding()
        let offset = keyboardHeight - bottomPadding + keyboardOffsetAdjustment
        
        updateUIWhenKeyboardWillShow(offset: offset)
        applyKeyboardAdjustment(offset: offset)
    }
    
    private func resetTransformableViews() {
        transformableView?.forEach { $0.transform = .identity }
    }
    
    private func applyKeyboardAdjustment(offset: CGFloat) {
        transformableView?.forEach {
            $0.transform = CGAffineTransform(translationX: 0, y: -offset)
        }
    }
    
    private func windowSafeAreaBottomPadding() -> CGFloat {
        guard let windowScene = view.window?.windowScene else { return 0 }
        return windowScene.windows.first?.safeAreaInsets.bottom ?? 0
    }
}
