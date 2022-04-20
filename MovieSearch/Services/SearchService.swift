//
//  SearchService.swift
//  MovieSearch
//
//  Created by BH on 2022/04/20.
//

import Foundation

class SearchService {
    
    static let shared = SearchService()

    func searchedMovies(movie: [Movie]) -> [MovieInfo] {
        
        let movieInfo: [MovieInfo] = movie.map { movie in
            let title = movie.title
                .replacingOccurrences(of: "<b>", with: "")
                .replacingOccurrences(of: "</b>", with: "")
            let director = movie.director
                .replacingOccurrences(of: "|", with: ",")
                .replacingOccurrences(of: "<b>", with: "")
                .replacingOccurrences(of: "</b>", with: "")
                .dropLast()
            let actor = movie.actor
                .replacingOccurrences(of: "|", with: ",")
                .replacingOccurrences(of: "<b>", with: "")
                .replacingOccurrences(of: "</b>", with: "")
                .dropLast()
            let movieData = Movie(title: title,
                                  image: movie.image,
                                  director: String(director),
                                  actor: String(actor),
                                  userRating: movie.userRating,
                                  link: movie.link)
            
            let movieInfoData = MovieInfo(movie: movieData,
                                          isLiked: false)
            
            return movieInfoData
        }
        return movieInfo
        
    }

}
