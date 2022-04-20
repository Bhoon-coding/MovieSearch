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
    
    func updateFavoriteMovie(movieInfo: MovieInfo) -> [MovieInfo] {
        var favoriteMovie: [MovieInfo] = []
        favoriteMovie = loadFavoriteMovie()
        
        favoriteMovie = favoriteMovie.filter {
            $0.movie.title != movieInfo.movie.title
        }
        
        saveFavoriteMovie(movieInfo: favoriteMovie)
        
        return favoriteMovie
        
    }
    
    func loadFavoriteMovie() -> [MovieInfo] {
        guard let loadData = defaults.value(forKey: "favoriteMovies") as? Data else { return [] }
        let favoriteMovies = try! PropertyListDecoder().decode([MovieInfo].self,
                                                              from: loadData)
        return favoriteMovies
    }
    
    func saveFavoriteMovie(movieInfo: [MovieInfo]) {
        defaults.set(try? PropertyListEncoder().encode(movieInfo), forKey: "favoriteMovies")
    }
}
