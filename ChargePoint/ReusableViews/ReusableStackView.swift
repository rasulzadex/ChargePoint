//
//  ReusableStackView.swift
//  ChargePoint
//
//  Created by Javidan on 27.02.25.
//

import UIKit

class ReusableStackView: UIStackView {
    
    init(
        arrangedSubviews: [UIView] = [],
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fillEqually,
        axis: NSLayoutConstraint.Axis = .vertical,
        spacing: CGFloat = 6
    ) {
        super.init(frame: .zero)
        self.alignment = alignment
        self.distribution = distribution
        self.axis = axis
        self.spacing = spacing
        arrangedSubviews.forEach { self.addArrangedSubview($0) }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
