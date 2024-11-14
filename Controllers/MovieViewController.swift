//
//  MovieViewController.swift
//  testiOS
//
//  Created by  Mukhammed Ali Khamzayev on 14.11.2024.
//

import UIKit

class MovieViewController: UIViewController {
    var movies: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        getMovies()
    }

    private func getMovies() {
        Task {
            do {
                let movies: MovieResponse = try await APICaller.shared.get(with: "/?page=0", and: .trendingMovies)
                self.movies = movies.movieResults
            } catch {
                print(error)
            }
        }
    }

    private func setup() {
        view = tableView
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Trend Movies"
    }
}

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: movies[indexPath.row])
        return cell
    }
}

extension MovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieDetailViewController(with: movies[indexPath.row].imdbID)
        navigationController?.pushViewController(vc, animated: true)
    }
}
