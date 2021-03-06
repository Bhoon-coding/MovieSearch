//
//  MovieDetailViewController.swift
//  MovieSearch
//
//  Created by BH on 2022/04/16.
//

import UIKit
import WebKit

final class MovieDetailViewController: UIViewController {
    
    // MARK: Properties
    
    var movie: Movie
    var movieInfo: MovieInfo
    var favoriteMoviesInfo: [MovieInfo] = []
    
    lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var movieInfoView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var movieInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var directorLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var actorLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var userRatingLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var starButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: movieInfo.isLiked ? "starFill" : "star")
                            , for: .normal)
        button.alpha = movieInfo.isLiked ? 1 : 0.1
        button.addTarget(self,
                         action: #selector(tappedStar),
                         for: .touchUpInside)
        return button
    }()
    
    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero,
                                configuration: webConfiguration)
        return webView
    }()
    
    
    // MARK: init
    
    init(movieInfo: MovieInfo) {
        self.movieInfo = movieInfo
        self.movie = movieInfo.movie
        
        super.init(nibName: nil, bundle: nil)
        
        
        movieImageView.load(urlString: movie.image)
        titleLabel.text = movie.title
        directorLabel.text = "??????: \(movie.director) "
        actorLabel.text = "??????: \(movie.actor)"
        userRatingLabel.text = "??????: \(movie.userRating)"
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        setUpUI()
        setUpWebView()
        
        favoriteMoviesInfo = UserDefaultsService.shared.loadFavoriteMoviesInfo()
        
    }
    
    // MARK: @objc
    
    @objc func tappedStar() {
        
        movieInfo.isLiked = !movieInfo.isLiked
        
        starButton.setImage(UIImage(named: movieInfo.isLiked ? "starFill" : "star")
                            , for: .normal)
        starButton.alpha = movieInfo.isLiked ? 1 : 0.1
        
        if movieInfo.isLiked {
            favoriteMoviesInfo.append(movieInfo)
        
        } else {
            favoriteMoviesInfo = UserDefaultsService.shared.updateFavoriteMoviesInfo(movieInfo: movieInfo)
        }
        
        UserDefaultsService.shared.saveFavoriteMovie(movieInfo: favoriteMoviesInfo)
        
        
    }
    
}

// MARK: extension - UI

private extension MovieDetailViewController {
    
    private func setUpNavigationBar() {
        
        navigationItem.title = movie.title
        
    }
    
    private func setUpUI() {
    
        view.backgroundColor = .white
        
        view.addSubview(contentScrollView)
        contentScrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.trailing.leading.equalToSuperview()
            $0.width.equalTo(view.frame.width)
        }
        
        contentScrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.top.trailing.bottom.leading.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(view.frame.height)
        }
        
        contentView.addSubview(movieInfoView)
        movieInfoView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.trailing.leading.equalToSuperview().inset(8)
            $0.height.equalTo(130)
        }
        
        movieInfoView.addSubview(movieImageView)
        movieImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview()
            $0.width.equalTo(88)
        }
        
        movieInfoView.addSubview(movieInfoStackView)
        movieInfoStackView.snp.makeConstraints {
            $0.leading.equalTo(movieImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(64)
            $0.top.bottom.equalToSuperview()
        }
        
        movieInfoStackView.addArrangedSubview(titleLabel)
        movieInfoStackView.addArrangedSubview(directorLabel)
        movieInfoStackView.addArrangedSubview(actorLabel)
        movieInfoStackView.addArrangedSubview(userRatingLabel)
        
        movieInfoView.addSubview(starButton)
        starButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(24)
        }
        
        contentView.addSubview(webView)
        webView.snp.makeConstraints {
            $0.top.equalTo(movieInfoView.snp.bottom)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)

        }
    }
    
    private func setUpWebView() {
        let movieURL = URL(string: movie.link)
        let request = URLRequest(url: movieURL!)
        webView.load(request)
    }
    
}
