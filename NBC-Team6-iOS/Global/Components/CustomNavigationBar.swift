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

// MARK: - CustomNavigationBar

final class CustomNavigationBar: UIView {
    
    // MARK: - Properties
    
    weak var delegate: CustomNavigationBarDelegate?
    
    private var viewType: NavigatonBarType?
    
    // MARK: - UI Properties
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
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
    
    // MARK: - Life Cycle
    
    init(viewType: NavigatonBarType, title: String?) {
        super.init(frame: CGRect.zero)
        
        self.viewType = viewType
        updateTitleView(with: title)
        setNavigationBarLayout()
        updateMypageButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        stackView.spacing = self.frame.width * 0.2
    }
}

// MARK: - Extensions

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
    
    private func setNavigationBarLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)

        [backButton, centerImageView, titleLabel, myPageButton].forEach { stackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            backButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2),
            myPageButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2),
            centerImageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2),
        ])
    }
    
    private func updateMypageButton() {
        if viewType == .withMypageButton {
            myPageButton.tintColor = .clear
        }
    }
    
    // MARK: - Action Helpers
    
    // backButton과 myPageButton의 액션 메서드
    @objc private func backButtonTapped() {
        delegate?.didTapBackButton()
    }
    
    @objc private func myPageButtonTapped() {
        delegate?.didTapMypageButton()
    }
}
