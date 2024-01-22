//
//  MovieListTableViewCell.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/18.
//

import UIKit

protocol MovieListTableViewCellDelegate: AnyObject {
    func movieCellDidTap(movie: MovieModel)
}

// MARK: - MovieListTableViewCell

final class MovieListTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "MovieListTableViewCell"
    
    weak var delegate: MovieListTableViewCellDelegate?
    
    var movieList: [MovieModel] = [] {
        didSet {
            movieListCollectionView.reloadData()
        }
    }
    
    // MARK: - UI Properties
    
    private lazy var movieListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier)
        collectionView.isScrollEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()

    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension MovieListTableViewCell {
    
    // MARK: - Layout Helpers
    
    private func setLayout() {
        contentView.addSubview(movieListCollectionView)
        
        NSLayoutConstraint.activate([
            movieListCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            movieListCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieListCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            movieListCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MovieListTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        
        return CGSize(width: screenWidth * 0.3, height: screenWidth * 0.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
}

// MARK: - UICollectionViewDataSource

extension MovieListTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier, for: indexPath) as? MovieListCollectionViewCell else { return UICollectionViewCell() }
        
        let movie = movieList[indexPath.item]
        cell.dataBind(with: movie)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = movieList[indexPath.row]
        delegate?.movieCellDidTap(movie: selectedMovie)
    }
}
