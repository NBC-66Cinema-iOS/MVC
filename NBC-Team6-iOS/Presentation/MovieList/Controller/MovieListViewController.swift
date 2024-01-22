//
//  MovieListViewController.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/16.
//

import UIKit

// MARK: - MovieListViewController

final class MovieListViewController: BaseViewController, CustomNavigationBarDelegate {
    
    // MARK: - Properties
    
    private var sectionTitles: [SectionTitleModel] = []
    private var movies: [String: [MovieModel]] = [:]
    
    private let tmdbClient = TMDBClient()
    
    // MARK: - UI Properties
    
    private let navigationBar = CustomNavigationBar(viewType: .standard, title: nil)
    
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
        updateMovieLists()
        setupNavigationBarDelegate()
    }
}

// MARK: - Extensions

extension MovieListViewController {
    
    // MARK: - Layout Helpers
    
    private func setLayout() {
        [navigationBar, categoryTableView].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            
            categoryTableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            categoryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Action Helpers
    
    private func updateMovieLists() {
        for sectionTitle in sectionTitles {
            updateMovieList(for: sectionTitle.title)
        }
    }
    
    // MARK: - General Helpers
    
    private func setupNavigationBarDelegate() {
        navigationBar.delegate = self
    }
    
    private func setupSectionTitles() {
        sectionTitles = [
            SectionTitleModel(title: "Upcoming"),
            SectionTitleModel(title: "NowPlaying"),
            SectionTitleModel(title: "Popular")
        ]
    }
}

// MARK: - UITableViewDelegate

extension MovieListViewController: UITableViewDelegate { }

// MARK: - UITableViewDataSource

extension MovieListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = sectionTitles[section].title
        label.frame = CGRect(x: 20, y: 5, width: tableView.frame.width, height: 35)
        headerView.addSubview(label)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return getDeviceHeight() * 0.04
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
        
        let category = sectionTitles[indexPath.section].title
        
        if let moviesInSection = movies[category] {
            // MovieModel 객체들을 MovieListTableViewCell에 전달
            cell.movieList = moviesInSection
        }
        
        cell.delegate = self
        
        return cell
    }
}

// MARK: - MovieListTableViewCellDelegate

extension MovieListViewController: MovieListTableViewCellDelegate {
    func movieCellDidTap(movie: MovieModel) {
        let detailVC = MovieDetailViewController()
        detailVC.movie = movie
        self.navigationController?.pushViewController(detailVC, animated: true)
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
                self.movies[category] = movies
                DispatchQueue.main.async {
                    if let sectionIndex = self.sectionTitles.firstIndex(where: { $0.title == category }) {
                        // 해당 섹션에 대한 IndexPath를 생성
                        let indexPath = IndexPath(row: 0, section: sectionIndex)
                        
                        // IndexPath에 대한 셀을 가져와 데이터를 설정
                        if let cell = self.categoryTableView.cellForRow(at: indexPath) as? MovieListTableViewCell {
                            cell.movieList = movies
                        }
                    }
                }
            case .failure(let error):
                // 에러 처리
                print("Error fetching movies: \(error.localizedDescription)")
            }
        }
    }
}
