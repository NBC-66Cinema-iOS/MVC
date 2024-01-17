//
//  CustomButton.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/16.
//

import UIKit

final class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontColor: UIColor, backColor: UIColor, title: String) {
        super.init(frame: .zero)
        
        configuration = .filled()
        configuration?.title = title
        configuration?.baseForegroundColor = fontColor
        configuration?.baseBackgroundColor = backColor
        configuration?.cornerStyle = .medium
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}

