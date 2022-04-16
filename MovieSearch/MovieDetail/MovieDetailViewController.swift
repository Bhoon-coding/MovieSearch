//
//  MovieDetailViewController.swift
//  MovieSearch
//
//  Created by BH on 2022/04/16.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    // MARK: Properties
    var movie: Movie
    
    // MARK: init
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle
    override func loadView() {
        super.loadView()
        
        navigationItem.title = movie.title
            .replacingOccurrences(of: "<b>", with: "")
            .replacingOccurrences(of: "</b>", with: "")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }
    
    // MARK: Methods
    
}

