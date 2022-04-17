//
//  MovieDetailViewController.swift
//  MovieSearch
//
//  Created by BH on 2022/04/16.
//

import UIKit
import WebKit

class MovieDetailViewController: UIViewController {
    
    // MARK: Properties
    var movie: Movie
    
    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero,
                                configuration: webConfiguration)
        return webView
    }()
    
    
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
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        setUpUI()
        setUpWebView()
        
    }
    
    // MARK: Methods
    
}

// MARK: extension - UI
private extension MovieDetailViewController {
    
    func setUpNavigationBar() {
        
        navigationItem.title = movie.title
            .replacingOccurrences(of: "<b>", with: "")
            .replacingOccurrences(of: "</b>", with: "")
        
    }
    
    func setUpUI() {
    
        view.backgroundColor = .white
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.top.trailing.leading.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            
        }
    }
    
    func setUpWebView() {
        let movieURL = URL(string: movie.link)
        let request = URLRequest(url: movieURL!)
        webView.load(request)
    }
    
}

// MARK: extension - WKWebView
extension MovieDetailViewController: WKUIDelegate {
    
    
}
