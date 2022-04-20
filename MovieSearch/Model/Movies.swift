//
//  Movies.swift
//  MovieSearch
//
//  Created by BH on 2022/04/14.
//

import Foundation

struct Movies: Codable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "items"
    }
}

struct Movie: Codable {
    
    var title: String
    var image: String
    var director: String
    var actor: String
    var userRating: String
    var link: String
    
}

struct MovieInfo: Codable {
    let movie: Movie
    var isLiked: Bool = false
}
