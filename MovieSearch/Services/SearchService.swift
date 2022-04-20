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
        
        var favoriteMoviesInfo: [MovieInfo] = []
        favoriteMoviesInfo = UserDefaultsService.shared.loadFavoriteMovie()
        
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
            
            var movieInfoData = MovieInfo(movie: movieData,
                                          isLiked: false)
            
            for favMovieInfo in favoriteMoviesInfo {
                if movieInfoData.movie.title == favMovieInfo.movie.title && favMovieInfo.isLiked == true {
                    movieInfoData.isLiked = true
                }
            }

            return movieInfoData
        }
        return movieInfo
        
    }

}
