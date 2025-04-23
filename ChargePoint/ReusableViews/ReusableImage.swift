//
//  ReImg.swift
//  MoovieeAPP
//
//  Created by Javidan on 20.12.24.
//

import Foundation

import UIKit

final class ReusableImage: UIImageView {
    private var imageName: String
    private var contentModeStyle: UIView.ContentMode
    private var cornerRadius: CGFloat

    init(
        imageName: String,
        contentMode: UIView.ContentMode = .scaleAspectFill,
        cornerRadius: CGFloat = 0
    ) {
        self.imageName = imageName
        self.contentModeStyle = contentMode
        self.cornerRadius = cornerRadius
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        image = UIImage(named: imageName)
        contentMode = contentModeStyle
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
    }
}
