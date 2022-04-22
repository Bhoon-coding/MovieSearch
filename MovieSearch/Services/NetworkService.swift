//
//  NetworkService.swift
//  MovieSearch
//
//  Created by BH on 2022/04/14.
//

import Foundation

import Alamofire

class NetworkService {
    static let shared = NetworkService()
    
    let urlString = "https://openapi.naver.com/v1/search/movie.json?"
    let clientID = APIConstant.clientID
    let clientSecret = APIConstant.clientSecret

    func fetchMovieData(keyword: String,
                        completion: @escaping (Result<Any, Error>) -> ()) {
        
        let searchParams = ["query": keyword]
    
        AF.request(urlString,
                   method: .get,
                   parameters: searchParams,
                   encoding: URLEncoding.default,
                   headers: ["X-Naver-Client-Id": clientID,
                             "X-Naver-Client-Secret": clientSecret])
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Movies.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value.movies))

                case .failure(let error):
                    completion(.failure(error))
                }
                
            }
        
    }
    
}
