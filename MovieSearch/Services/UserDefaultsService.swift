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
    
    func loadStarredMovie() -> [Movie] {
        guard let loadData = defaults.value(forKey: "starredMovies") as? Data else { return [] }
        let starredMovies = try! PropertyListDecoder().decode([Movie].self,
                                                              from: loadData)
        return starredMovies
    }
    
    func saveStarredMovie(movie: [Movie]) {
        defaults.set(try? PropertyListEncoder().encode(movie), forKey: "starredMovies")
    }
}
