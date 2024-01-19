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
        label.text = "블라블라"
        
        return label
    }
    
    static func makeBoldLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bold"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        
        return label
    }
    
    static func makeMediumLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Medium"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        
        return label
    }
    
    static func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        
        return scrollView
    }
}
