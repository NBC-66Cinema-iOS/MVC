//
//  MovieDetailViewController.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/16.
//

import UIKit

final class MovieDetailViewController: BaseViewController, CustomNavigationBarDelegate {
    
    var movie: MovieModel?
    
    private let rootView = MovieDetailView()
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMovieDatas()
        setDelegate()
    }
}

// MARK: - Network

extension MovieDetailViewController {
    private func setDelegate() {
        rootView.navigationBar.delegate = self
    }
    
    private func fetchMovieDatas() {
        guard let movie = movie else { return }
        
        rootView.movieImageView.load(from: movie.absoluteImagePath)
        rootView.titleLabel.text = movie.title
        rootView.descriptionLabel.text = movie.overview
    }
}
