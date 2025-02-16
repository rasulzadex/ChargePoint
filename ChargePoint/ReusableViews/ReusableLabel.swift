
//
//  ReusableLabel.swift
//  BankAPP
//
//  Created by Javidan on 15.11.24.
//

import UIKit

class ReusableLabel: UILabel {
    private var labelText: String
    private var textAlignmentStyle: NSTextAlignment
    private var fontName: String?
    private var fontSize: CGFloat?
    private var textColorStyle: UIColor
    private var numberOfLinesStyle: Int
    private var cornerRadiusValue: CGFloat?
    
    init(text: String,
         textAlignment: NSTextAlignment = .left,
         fontName: String?,
         fontSize: CGFloat?,
         textColor: UIColor,
         numberOfLines: Int = 0,
         cornerRadius: CGFloat? = nil) {
        self.labelText = text
        self.textAlignmentStyle = textAlignment
        self.fontName = fontName
        self.fontSize = fontSize
        self.textColorStyle = textColor
        self.numberOfLinesStyle = numberOfLines
        self.cornerRadiusValue = cornerRadius
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI() {
        text = labelText
        textAlignment = textAlignmentStyle
        
        if let fontName = fontName, let fontSize = fontSize {
            font = UIFont(name: fontName, size: fontSize)
        } else if fontName == "" {
            font = UIFont.systemFont(ofSize: fontSize ?? UIFont.systemFontSize)
        }
        
        textColor = textColorStyle
        numberOfLines = numberOfLinesStyle
        translatesAutoresizingMaskIntoConstraints = false
        
        if let radius = cornerRadiusValue {
            layer.cornerRadius = radius
            clipsToBounds = true
        }
    }
    
}
