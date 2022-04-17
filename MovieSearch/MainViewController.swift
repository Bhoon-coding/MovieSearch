//
//  ViewController.swift
//  MovieSearch
//
//  Created by BH on 2022/04/13.
//

import UIKit

import SnapKit

class MainViewController: UIViewController {
    
    // MARK: Properties
    
    var movies: [Movie] = []
    var starredMovie: [Movie] = []
    
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
        button.addTarget(self,
                         action: #selector(tappedFavoriteButton),
                         for: .touchUpInside)
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
        starredMovie = UserDefaultsService.shared.loadStarredMovie()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        setUpUI()
        setDelegate()
    
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
        button.isSelected = !button.isSelected
        print("test index: \(index)")
        
        if button.isSelected {
            starredMovie.append(movies[index])
            
        } else {
            
            let removeStarredMovie = starredMovie.filter { $0.title != movies[index].title }
            starredMovie = removeStarredMovie
        }
        
        button.alpha = button.isSelected ? 1 : 0.1
        button.setImage(UIImage(named: "starFill"), for: .selected)
        
        UserDefaultsService.shared.saveStarredMovie(movie: starredMovie)
        
        // TODO: [x] 즐겨찾기 레이아웃, 활성/비활성화
        // [x] 즐겨찾기 활성화시 즐겨찾는 배열에 저장
        
    }
    
    @objc func tappedFavoriteButton() {
        
        let favoriteVC = FavoriteViewController()
        navigationController?.pushViewController(favoriteVC, animated: true)
        
        
        searchBar.resignFirstResponder()
    }
    
}

// MARK: extension - UI
private extension MainViewController {
    
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
            $0.top.trailing.equalToSuperview()
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
extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // TODO: 영화 API 호출
        guard let keyword = searchBar.text else { return }
        NetworkService.shared.fetchMovieData(keyword: keyword) { result in
            switch result {
            case .success(let movieData):
                guard let movieData = movieData as? [Movie] else { return }
                self.movies = movieData
                
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
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    // DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier,
                                                 for: indexPath) as! MovieListTableViewCell
        
        
        
        cell.set(movies: movies[indexPath.row])
        cell.starButton.tag = indexPath.row
        cell.starButton.addTarget(self,
                                  action: #selector(tappedStar(button:)),
                                  for: .touchUpInside)
        
        return cell
    }
    
    // Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movieDetailVC = MovieDetailViewController(movie: movies[indexPath.row])
        navigationController?.pushViewController(movieDetailVC, animated: true)
        
        searchBar.resignFirstResponder()
    }

}
