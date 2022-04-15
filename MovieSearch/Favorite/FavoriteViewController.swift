//
//  FavoriteViewController.swift
//  MovieSearch
//
//  Created by BH on 2022/04/15.
//

import UIKit

import SnapKit

final class FavoriteViewController: UIViewController {
    
    var starredMovies: [Movie] = []
    
    // MARK: Properties
    lazy var starredListTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieListTableViewCell.self,
                           forCellReuseIdentifier: MovieListTableViewCell.identifier)
        tableView.rowHeight = 130
        return tableView
    }()
    
    // MARK: LifeCycle
    override func loadView() {
        super.loadView()
        starredMovies = UserDefaultsService.shared.loadStarredMovie()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "즐겨찾기 목록"
        
        setUpUI()
        setUpDelegate()
    }
    
    // MARK: Methods
    
    private func setUpDelegate() {
        starredListTableView.delegate = self
        starredListTableView.dataSource = self
    }
}

private extension FavoriteViewController {
    
    func setUpUI() {
        
        view.backgroundColor = .white
        
        view.addSubview(starredListTableView)
        starredListTableView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(16)
        }
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier, for: indexPath) as! MovieListTableViewCell
        
        cell.set(movies: starredMovies[indexPath.row])
        return cell
    }
    
    
}
