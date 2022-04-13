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
    
//    let starImage = UIImage(named: "starFill")
    
    lazy var safeAreaView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "네이버 영화 검색"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        // TODO: star 이미지크기 조절
//        button.setImage(starImage, for: .normal)
        button.setTitle("즐겨찾기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        
        return button
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        setDelegate()
    
    }
    
    // MARK: Methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.resignFirstResponder()
    }
    
    private func setUpUI() {
        
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
    }
    
    private func setDelegate() {
        searchBar.delegate = self
    }
    
    
    // MARK: @objc

}

// MARK: extension

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // TODO: 영화 API 호출
        searchBar.resignFirstResponder()
    }
}
