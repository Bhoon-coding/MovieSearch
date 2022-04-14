//
//  Movies.swift
//  MovieSearch
//
//  Created by BH on 2022/04/14.
//

import Foundation

struct Movies: Codable {
    let total: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case total
        case movies = "items"
    }
}

struct Movie: Codable {
    let title: String
    let image: String
    let director: String
    let actor: String
    let userRating: String
    
}
