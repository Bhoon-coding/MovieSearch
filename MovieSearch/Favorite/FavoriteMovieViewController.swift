//
//  FavoriteViewController.swift
//  MovieSearch
//
//  Created by BH on 2022/04/15.
//

import UIKit

import SnapKit

final class FavoriteMovieViewController: UIViewController {
    
    var favoriteMovies: [MovieInfo] = []
    
    // MARK: Properties
    lazy var favoriteListTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FavoriteMovieTableViewCell.self,
                           forCellReuseIdentifier: FavoriteMovieTableViewCell.identifer)
        tableView.rowHeight = 130
        return tableView
    }()
    
    // MARK: LifeCycle
    override func loadView() {
        super.loadView()
        favoriteMovies = UserDefaultsService.shared.loadFavoriteMovie()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "즐겨찾기 목록"
        setUpNavigationBar()
        setUpUI()
        setUpDelegate()
    }
    
    // MARK: Methods
    
    private func setUpDelegate() {
        favoriteListTableView.delegate = self
        favoriteListTableView.dataSource = self
    }
    
    // MARK: @objc
    @objc func tappedFavoriteButton(button: UIButton) {

        let index = button.tag
        
        favoriteMovies[index].isLiked = !favoriteMovies[index].isLiked
        
        if !favoriteMovies[index].isLiked {
            favoriteMovies = favoriteMovies.filter { $0.isLiked }
            DispatchQueue.main.async {
                self.favoriteListTableView.reloadData()
            }
        }
        
    }
}

private extension FavoriteMovieViewController {
    
    func setUpNavigationBar() {
        let backBarButtonItem = UIBarButtonItem(title: nil,
                                                style: .plain,
                                                target: self,
                                                action: nil)
        backBarButtonItem.tintColor = .black
        navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    func setUpUI() {
        
        view.backgroundColor = .white
        
        view.addSubview(favoriteListTableView)
        favoriteListTableView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(16)
        }
    }
}

extension FavoriteMovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    // DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteMovieTableViewCell.identifer, for: indexPath) as! FavoriteMovieTableViewCell
        
        cell.configure(movieInfo: favoriteMovies[indexPath.row])
        cell.starButton.tag = indexPath.row
        cell.starButton.addTarget(self, action: #selector(tappedFavoriteButton(button:)),
                                  for: .touchUpInside)
        
        return cell
    }
    
    // Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailVC = MovieDetailViewController(movieInfo: favoriteMovies[indexPath.row])
        navigationController?.pushViewController(movieDetailVC, animated: true)
        
    }
}
