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
