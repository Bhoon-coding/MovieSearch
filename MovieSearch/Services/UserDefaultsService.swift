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
    
    func loadFavoriteMovie() -> [Movie] {
        guard let loadData = defaults.value(forKey: "favoriteMovies") as? Data else { return [] }
        let favoriteMovies = try! PropertyListDecoder().decode([Movie].self,
                                                              from: loadData)
        return favoriteMovies
    }
    
    func saveFavoriteMovie(movie: [Movie]) {
        defaults.set(try? PropertyListEncoder().encode(movie), forKey: "favoriteMovies")
    }
}
