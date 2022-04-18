//
//  Movies.swift
//  MovieSearch
//
//  Created by BH on 2022/04/14.
//

import Foundation

struct Movies: Codable {
    let movies: [MovieInfo]
    
    enum CodingKeys: String, CodingKey {
        case movies = "items"
    }
}

struct MovieInfo: Codable {
    
    var title: String
    var image: String
    var director: String
    var actor: String
    var userRating: String
    var link: String
    
}

struct Movie: Codable {
    let movieInfo: MovieInfo
    var isLiked: Bool = false
}
