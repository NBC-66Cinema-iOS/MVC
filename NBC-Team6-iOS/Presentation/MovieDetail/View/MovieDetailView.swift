//
//  MovieDetailView.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/18.
//

import UIKit

class MovieDetailView: UIView {
    
    private let navigationBar = CustomNavigationBar(title: "상세보기")
    
    private let movieImageView = ComponentFactory.makeMoviePosterImageView()
    private let titleLabel = ComponentFactory.makeMediumLabel()
    private let descriptionLabel = ComponentFactory.makeMediumLabel()
    
    private lazy var reservationButton = CustomButton(fontColor: .white, backColor: .black, title: "예약하기")

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieDetailView {
    private func setLayout() {
        [navigationBar, movieImageView, titleLabel, descriptionLabel, reservationButton].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalToSystemSpacingBelow: self.safeAreaLayoutGuide.topAnchor, multiplier: 15),
            // 왜 snapkit
            movieImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.frame.size.width * 0.3),
            movieImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: movieImageView.bottomAnchor, multiplier: 1),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1),
            descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            reservationButton.bottomAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: safeAreaLayoutGuide.bottomAnchor, multiplier: 0.1),
            reservationButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
