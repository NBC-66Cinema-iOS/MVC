//
//  MovieListViewController.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/16.
//

import UIKit

// MARK: - MovieListViewController

final class MovieListViewController: UIViewController {
    
    // MARK: - Properties
    
    private var sectionTitles: [SectionTitleModel] = []
    private var movies: [String: [MovieModel]] = [:]
    
    private let tmdbClient = TMDBClient()
    
    // MARK: - UI Properties
    
    private let navigationBar = CustomNavigationBar(title: nil)
    
    private lazy var categoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .black.withAlphaComponent(0.1)
        tableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: MovieListTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        setupSectionTitles()
        for sectionTitle in sectionTitles {
            updateMovieList(for: sectionTitle.title)
        }
    }
}

// MARK: - Extensions

extension MovieListViewController {
    
    // MARK: - Layout Helpers
    
    private func setLayout() {
        [navigationBar, categoryTableView].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            categoryTableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            categoryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Action Helpers
    
    // MARK: - General Helpers
    
    private func setupSectionTitles() {
        sectionTitles = [
            SectionTitleModel(title: "Upcoming"),
            SectionTitleModel(title: "NowPlaying"),
            SectionTitleModel(title: "Popular")
        ]
    }
}

// MARK: - UITableViewDelegate

extension MovieListViewController: UITableViewDelegate {

}

// MARK: - UITableViewDataSource

extension MovieListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UITableViewHeaderFooterView(reuseIdentifier: "SectionHeader")
        headerView.textLabel?.text = sectionTitles[section].title
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        
        return screenHeight * 0.2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier, for: indexPath) as? MovieListTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}

// MARK: - Network

extension MovieListViewController {
    private func fetchMovies(for category: String, completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        switch category {
        case "Upcoming":
            tmdbClient.fetchUpcomingMovies(completion: completion)
        case "NowPlaying":
            tmdbClient.fetchNowPlayingMovies(completion: completion)
        case "Popular":
            tmdbClient.fetchPopularMovies(completion: completion)
        default:
            break
        }
    }

    private func updateMovieList(for category: String) {
        fetchMovies(for: category) { [weak self] result in
            switch result {
            case .success(let movies):
                // 성공적으로 데이터를 받아왔을 때 해당 카테고리의 데이터 갱신
                guard let self = self else { return }
                let movieList = movies
                DispatchQueue.main.async {
                    self.categoryTableView.reloadData()
                }
            case .failure(let error):
                // 에러 처리
                print("Error fetching movies: \(error.localizedDescription)")
            }
        }
    }
}
