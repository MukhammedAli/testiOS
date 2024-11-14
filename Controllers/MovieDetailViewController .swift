//
//  MovieDetailViewController .swift
//  testiOS
//
//  Created by  Mukhammed Ali Khamzayev on 14.11.2024.
//

import Kingfisher
import WebKit
import SnapKit
import UIKit

final class MovieDetailViewController: UIViewController {
    struct Constants {
        static let youtubeURL = "https://www.youtube.com/embed/"
    }
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private let titleLabel: UILabel  = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let yearLabel: UILabel  = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel  = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let webView = WKWebView()
    
    private let id: String

    init(with id: String) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        getMovieDetail()
    }

    required init?(coder: NSCoder) {
        nil
    }
    
    @objc
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func getMovieDetail() {
        Task {
            do {
                async let movieRequest: MovieDetail = APICaller.shared.get(with: "?movieid=\(id)", and: .detail)
                async let imageRequest: MovieImageResponse = APICaller.shared.get(with: "?movieid=\(id)", and: .image)

                let (movie, image) = try await (movieRequest, imageRequest)
                configureMovie(with: movie, and: image.poster)
            } catch {
                print(error)
            }
        }
    }
    
    private func configureMovie(with movie: MovieDetail, and url: String) {
        descriptionLabel.text = movie.description
        posterImageView.kf.setImage(with: URL(string: url))
        navigationItem.title = movie.title + " (\(movie.year))"

        guard !movie.youtubeTrailerKey.isEmpty, let url = URL(string: Constants.youtubeURL + movie.youtubeTrailerKey) else { return
        }

        webView.load(URLRequest(url: url))
    }

    private func setup() {
        view.backgroundColor = .systemBackground
        [posterImageView, titleLabel, yearLabel, descriptionLabel, webView].forEach { view.addSubview($0) }
        
        setupConstraints()
        setupBackButton()
    }

    private func setupConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(200)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(20)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
        webView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.height.equalTo(200)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    private func setupBackButton() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .label
        navigationItem.leftBarButtonItem = backButton
    }
}
