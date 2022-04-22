//
//  UserDefaultsService.swift
//  MovieSearch
//
//  Created by BH on 2022/04/15.
//

import Foundation

class UserDefaultsService {
    
    // MARK: Properties
    
    static let shared = UserDefaultsService()
    let defaults = UserDefaults.standard
    
    // MARK: Methods
    
    func updateFavoriteMoviesInfo(movieInfo: MovieInfo) -> [MovieInfo] {
        var favoriteMoviesInfo: [MovieInfo] = []
        favoriteMoviesInfo = loadFavoriteMoviesInfo()
        
        favoriteMoviesInfo = favoriteMoviesInfo.filter {
            $0.movie.title != movieInfo.movie.title &&
            $0.movie.director != movieInfo.movie.director &&
            $0.movie.actor != movieInfo.movie.actor
        }
        
        saveFavoriteMovie(movieInfo: favoriteMoviesInfo)
        
        return favoriteMoviesInfo
        
    }
    
    func loadFavoriteMoviesInfo() -> [MovieInfo] {
        guard let loadData = defaults.value(forKey: "favoriteMovies") as? Data else { return [] }
        let favoriteMovies = try! PropertyListDecoder().decode([MovieInfo].self,
                                                              from: loadData)
        return favoriteMovies
    }
    
    func saveFavoriteMovie(movieInfo: [MovieInfo]) {
        defaults.set(try? PropertyListEncoder().encode(movieInfo), forKey: "favoriteMovies")
    }
}
