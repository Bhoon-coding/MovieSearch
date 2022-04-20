//
//  FavoriteMovieTableViewCell.swift
//  MovieSearch
//
//  Created by BH on 2022/04/18.
//

import UIKit

class FavoriteMovieTableViewCell: UITableViewCell {
    
    // MARK: Properties
    static let identifer = "FavoriteMovieTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        button.setImage(UIImage(named: "starFill"), for: .normal)
        return button
    }()
    
    // MARK: Methods
    func configure(movieInfo: MovieInfo) {
        let movie = movieInfo.movie
        
        movieImageView.load(urlString: movie.image)
        titleLabel.text = movie.title
        directorLabel.text = "감독: \(movie.director) "
        actorLabel.text = "출연: \(movie.actor)"
        userRatingLabel.text = "평점: \(movie.userRating)"
    }
    
}

private extension FavoriteMovieTableViewCell {
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
        }
        
    }
}
