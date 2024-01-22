//
//  MovieDetailView.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/18.
//

import UIKit

protocol MovieDetailViewDelegate: AnyObject {
    func reservationButtonTapped()
}

final class MovieDetailView: UIView {
    
    weak var delegate: CustomNavigationBarDelegate? {
        didSet {
            navigationBar.delegate = delegate
        }
    }
    
    weak var reservationDelegate: MovieDetailViewDelegate?
    
    private let navigationBar = CustomNavigationBar(viewType: .standard, title: nil)
    
    private let movieImageView = ComponentFactory.makeMoviePosterImageView()
    private let titleLabel = ComponentFactory.makeBoldLabel()
    private let descriptionLabel = ComponentFactory.makeDescriptionLabel()
    
    private lazy var reservationButton = CustomButton(fontColor: .white, backColor: .black, title: "예약하기")

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        addButtonTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieDetailView {
    private func setLayout() {
        [navigationBar, movieImageView, titleLabel, descriptionLabel, reservationButton].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            
            movieImageView.topAnchor.constraint(equalToSystemSpacingBelow: navigationBar.bottomAnchor, multiplier: 5),
            // 왜 snapkit
            movieImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.frame.size.width * 0.3),
            movieImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: movieImageView.bottomAnchor, multiplier: 5),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
            descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 3),
            descriptionLabel.trailingAnchor.constraint(equalToSystemSpacingAfter: self.trailingAnchor, multiplier: -3),
            
            reservationButton.bottomAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.bottomAnchor, multiplier: 0.1),
            reservationButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            reservationButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            reservationButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05)
        ])
    }
    
    func updateMovieImage(from path: String) {
        movieImageView.load(from: path)
    }

    func updateTitle(_ title: String) {
        titleLabel.text = title
    }

    func updateDescription(_ description: String) {
        descriptionLabel.text = description
    }
    
    private func addButtonTarget() {
        reservationButton.addTarget(self, action: #selector(handleReservationButtonTapped), for: .touchUpInside)
    }
    
    @objc func handleReservationButtonTapped() {
        reservationDelegate?.reservationButtonTapped()
    }
}
