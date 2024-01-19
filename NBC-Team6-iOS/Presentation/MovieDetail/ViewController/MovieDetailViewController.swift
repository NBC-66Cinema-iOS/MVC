//
//  MovieDetailViewController.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/16.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    
    private let rootView = MovieDetailView()
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }
}

extension MovieDetailViewController {
    
}
