//
//  ViewController.swift
//  MovieSearch
//
//  Created by BH on 2022/04/13.
//

import UIKit

import SnapKit

class MovieViewController: UIViewController {
    
    // MARK: Properties
    var movies: [Movie] = []
    var moviesInfo: [MovieInfo] = []
    var favoriteMoviesInfo: [MovieInfo] = []
    
    lazy var safeAreaView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "네이버 영화 검색"
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setTitle("즐겨찾기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.setImage(UIImage(named: "starFill"), for: .normal)
        button.addTarget(self,
                         action: #selector(tappedFavoriteButton),
                         for: .touchUpInside)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 5
        return button
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    lazy var movieListTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieListTableViewCell.self,
                           forCellReuseIdentifier: MovieListTableViewCell.identifier)
        tableView.rowHeight = 130
        return tableView
    }()
    
    // MARK: LifeCycle
    
    override func loadView() {
        super.loadView()
        favoriteMoviesInfo = UserDefaultsService.shared.loadFavoriteMoviesInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        setUpUI()
        setDelegate()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteMoviesInfo = UserDefaultsService.shared.loadFavoriteMoviesInfo()
        
        moviesInfo = SearchService.shared.searchedMovies(movie: movies)
        DispatchQueue.main.async {
            self.movieListTableView.reloadData()
        }
    }

    // MARK: Methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.resignFirstResponder()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    private func setDelegate() {
        searchBar.delegate = self
        movieListTableView.delegate = self
        movieListTableView.dataSource = self
    }
    
    // MARK: @objc
    @objc func tappedStar(button: UIButton) {
        let index = button.tag
        moviesInfo[index].isLiked = !(moviesInfo[index].isLiked)
        button.alpha = moviesInfo[index].isLiked ? 1 : 0.1
        
        if moviesInfo[index].isLiked {
            button.setImage(UIImage(named: "starFill"), for: .normal)
            
            favoriteMoviesInfo.append(moviesInfo[index])
            UserDefaultsService.shared.saveFavoriteMovie(movieInfo: favoriteMoviesInfo)
            
        } else {
            button.setImage(UIImage(named: "star"), for: .normal)
            
            favoriteMoviesInfo = UserDefaultsService.shared.updateFavoriteMoviesInfo(movieInfo: moviesInfo[index])
        }
    }
    
    @objc func tappedFavoriteButton() {
        
        let favoriteMovieVC = FavoriteMovieViewController()
        navigationController?.pushViewController(favoriteMovieVC, animated: true)
        
        
        searchBar.resignFirstResponder()
    }
    
}

// MARK: extension - UI
private extension MovieViewController {
    
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
        
        view.addSubview(safeAreaView)
        safeAreaView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        safeAreaView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }

        safeAreaView.addSubview(favoriteButton)
        favoriteButton.snp.makeConstraints {
            $0.top.bottom.equalTo(titleLabel)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(88)
        }
        
        safeAreaView.addSubview(searchBar)
        searchBar.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview()
        }
        
        safeAreaView.addSubview(movieListTableView)
        movieListTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: extension - SearchBar
extension MovieViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // TODO: 영화 API 호출
        guard let keyword = searchBar.text else { return }
        NetworkService.shared.fetchMovieData(keyword: keyword) { result in
            switch result {
            case .success(let movieData):
                
                guard let movieData = movieData as? [Movie] else { return }
                self.movies = movieData
                self.moviesInfo = SearchService.shared.searchedMovies(movie: self.movies)
                
                DispatchQueue.main.async {
                    self.movieListTableView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
        searchBar.resignFirstResponder()
    }
}

// MARK: extension - TableView
extension MovieViewController: UITableViewDataSource, UITableViewDelegate {
    // DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesInfo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier,
                                                 for: indexPath) as! MovieListTableViewCell
        
        cell.configure(movieInfo: moviesInfo[indexPath.row])
        
        cell.starButton.tag = indexPath.row
        cell.starButton.addTarget(self,
                                  action: #selector(tappedStar(button:)),
                                  for: .touchUpInside)
        
        return cell
    }
    
    // Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movieDetailVC = MovieDetailViewController(movieInfo: moviesInfo[indexPath.row])
        navigationController?.pushViewController(movieDetailVC, animated: true)
        
        searchBar.resignFirstResponder()
    }

}
