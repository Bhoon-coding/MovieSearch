//
//  MovieListTableViewCell.swift
//  MovieSearch
//
//  Created by BH on 2022/04/13.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    // MARK: Properties
    static let identifier = "MovieListTableViewCell"
    
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
        button.setImage(UIImage(named: "star"), for: .normal)
        return button
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
//    func configure(movies: Movie) {
//        let title = movies.title
//            .replacingOccurrences(of: "<b>", with: "")
//            .replacingOccurrences(of: "</b>", with: "")
//        let director = movies.director
//            .dropLast()
//        let actor = movies.actor
//            .replacingOccurrences(of: "|", with: ",")
//            .dropLast()
//
//        movieImageView.load(urlString: movies.image)
//        titleLabel.text = title
//        directorLabel.text = "감독: \(director) "
//        actorLabel.text = "출연: \(actor)"
//        userRatingLabel.text = "평점: \(movies.userRating)"
//    }
    
    func configure(movie: Movie) {
        let movieInfo = movie.movieInfo
        let title = movieInfo.title
            .replacingOccurrences(of: "<b>", with: "")
            .replacingOccurrences(of: "</b>", with: "")
        let director = movieInfo.director
            .dropLast()
        let actor = movieInfo.actor
            .replacingOccurrences(of: "|", with: ",")
            .dropLast()
        
        movieImageView.load(urlString: movieInfo.image)
        titleLabel.text = title
        directorLabel.text = "감독: \(director) "
        actorLabel.text = "출연: \(actor)"
        userRatingLabel.text = "평점: \(movieInfo.userRating)"
        
        starButton.setImage(UIImage(named: movie.isLiked ? "starFill" : "star" ), for: .normal)
        starButton.alpha = movie.isLiked ? 1 : 0.3
    }
    override func prepareForReuse() {
        starButton.setImage(UIImage(named: "star"), for: .normal)
    }
}

private extension MovieListTableViewCell {
    // MARK: Cell Layout
    private func setUpCell() {
        
        contentView.addSubview(movieImageView)
        movieImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview()
            $0.width.equalTo(88)
        }
        
        contentView.addSubview(movieInfoStackView)
        movieInfoStackView.snp.makeConstraints {
            $0.leading.equalTo(movieImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(56)
            $0.top.bottom.equalToSuperview()
        }
        movieInfoStackView.addArrangedSubview(titleLabel)
        movieInfoStackView.addArrangedSubview(directorLabel)
        movieInfoStackView.addArrangedSubview(actorLabel)
        movieInfoStackView.addArrangedSubview(userRatingLabel)
        
        contentView.addSubview(starButton)
        starButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(24)
        }
        
    }
}
