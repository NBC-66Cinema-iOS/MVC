//
//  ComponentFactory.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/18.
//

import UIKit

struct ComponentFactory {
    static func makeMoviePosterImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray
        
        return imageView
    }
    
    static func makeMovieTitleLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        label.text = "makeMovieTitleLabel"
        
        return label
    }
    
    static func makeBoldLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.lineBreakMode = .byTruncatingTail
        label.text = "makeBoldLabel"
        
        return label
    }
    
    static func makeMediumLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.lineBreakMode = .byTruncatingTail
        label.text = "makeMediumLabel"
        
        return label
    }
    
    static func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        
        return scrollView
    }
}
