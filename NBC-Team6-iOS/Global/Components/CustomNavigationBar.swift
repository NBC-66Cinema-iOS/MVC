//
//  CustomNavigationBar.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/20.
//

import UIKit

enum NavigatonBarType {
    case standard
    case withMypageButton
}

final class CustomNavigationBar: UIView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = stackView.frame.width * 1/5
        
        return stackView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "backButtonImage"), for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let centerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "centerImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    private lazy var myPageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "myPageButtonImage"), for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(myPageButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    init(title: String?) {
        super.init(frame: CGRect.zero)
        updateTitleView(with: title)
        setNavigationBarLayout()
    }
    
    // TODO: 트러블 슈팅
    override func didMoveToSuperview() {
        setNavigationBarConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension CustomNavigationBar {
    private func updateTitleView(with title: String?) {
        if let title = title {
            titleLabel.text = title
            titleLabel.isHidden = false
            centerImageView.isHidden = true
        } else {
            titleLabel.isHidden = true
            centerImageView.isHidden = false
        }
    }
    
    private func setNavigationBarConstraint() {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview?.safeAreaLayoutGuide.topAnchor ?? NSLayoutYAxisAnchor()),
            leadingAnchor.constraint(equalTo: superview?.safeAreaLayoutGuide.leadingAnchor ?? NSLayoutXAxisAnchor()),
            trailingAnchor.constraint(equalTo: superview?.safeAreaLayoutGuide.trailingAnchor ?? NSLayoutXAxisAnchor()),
            heightAnchor.constraint(equalTo: superview?.heightAnchor ?? NSLayoutDimension(), multiplier: 0.1)
        ])
    }
    
    private func setNavigationBarLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)

        [backButton, titleLabel.isHidden ? centerImageView : titleLabel, myPageButton].forEach { stackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            backButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1/5),
            myPageButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1/5),
            centerImageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1/5),
        ])
    }
    
    // MARK: - Action Helpers
    
    // backButton과 myPageButton의 액션 메서드
    @objc private func backButtonTapped() {
        // backButton을 눌렀을 때 수행할 동작
    }
    
    @objc private func myPageButtonTapped() {
        // myPageButton을 눌렀을 때 수행할 동작
    }
}
