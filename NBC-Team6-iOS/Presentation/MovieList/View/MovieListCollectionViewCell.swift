//
//  MovieListCollectionViewCell.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/18.
//

import UIKit

// MARK: - MovieListCollectionViewCell

final class MovieListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieListCollectionViewCell"
    
    private lazy var movieImageView = ComponentFactory.makeMoviePosterImageView()
    private lazy var movieTitleLabel = ComponentFactory.makeMovieTitleLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension MovieListCollectionViewCell {
    
    // MARK: - Layout Helpers
    
    private func setLayout() {
        [movieImageView, movieTitleLabel].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: self.topAnchor),
            movieImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            
            movieTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor),
            movieTitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: movieImageView.bottomAnchor, multiplier: 0.5)
        ])
    }
    
    // MARK: - Action Helpers
    
    // MARK: - General Helpers
    
    func dataBind(with model: MovieListModel) {
        movieImageView.image = model.image
        movieTitleLabel.text = model.title
    }
}

