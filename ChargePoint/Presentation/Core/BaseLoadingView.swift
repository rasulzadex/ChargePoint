//
//  BaseLoadingView.swift
//  ChargePoint
//
//  Created by Javidan on 29.12.25.
//
import UIKit

public final class BaseLoadingView: UIView {
    
    public enum Style {
        case inline
        case fullscreen(backgroundColor: UIColor = UIColor.white.withAlphaComponent(0.5))
    }
    
    private let style: Style
    
    private let activityIndicator = UIActivityIndicatorView(style: .medium).withUsing {
        $0.color = .evTurquoise
    }
    
    public init(style: Style) {
        self.style = style
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        switch style {
            case .inline:
                backgroundColor = .clear
            case .fullscreen(let bgColor):
                backgroundColor = bgColor
        }
        
        addSubview(activityIndicator)
        
        activityIndicator.centerXToSuperview()
        activityIndicator.centerYToSuperview()
        activityIndicator.anchorSize(.init(width: 32, height: 32))
        activityIndicator.startAnimating()
    }
    
    public func start() {
        isHidden = false
        activityIndicator.startAnimating()
    }
    
    public func stop() {
        activityIndicator.stopAnimating()
        isHidden = true
    }
}
