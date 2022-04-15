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
    let title: String
    let image: String
    var director: String
    var actor: String
    let userRating: String
    
}
