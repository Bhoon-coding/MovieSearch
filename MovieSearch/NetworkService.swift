//
//  NetworkService.swift
//  MovieSearch
//
//  Created by BH on 2022/04/14.
//

import Foundation

import Alamofire

struct NetworkService {
    static let shared = NetworkService()
    
    let urlString = "https://openapi.naver.com/v1/search/movie.json?"
    let clientID = APIConstant.clientID
    let clientSecret = APIConstant.clientSecret

    // MARK: Alamofire
    // TODO: fetchMovieData 파라미터에 '검색'을 눌렀을때 입력된 text를 보내줘야함.
    func fetchMovieData(keyword: String, completion: @escaping (Result<Any, Error>) -> ()) {
        
        let searchParams = ["query": keyword]
    
        AF.request(urlString,
                   method: .get,
                   parameters: searchParams,
                   encoding: URLEncoding.default,
                   headers: ["X-Naver-Client-Id": clientID, "X-Naver-Client-Secret": clientSecret])
            .responseDecodable(of: Movies.self) { response in
                guard let movies = response.value else { return }
                debugPrint(movies)
                
            }
        
    }
    
    // MARK: URLSession
//    func fetchMovieData(completion: @escaping (Result<Any, Error>) -> ()) {
//        if let url = URL(string: urlString) {
//            let session = URLSession(configuration: .default)
//
//            var requestURL = URLRequest(url: url)
//            requestURL.addValue(clientID, forHTTPHeaderField: "x-naver-client-id")
//            requestURL.addValue(clientSecret, forHTTPHeaderField: "x-naver-client-secret")
//
//            let dataTask = session.dataTask(with: requestURL) { data, response, error in
//                if error != nil {
//                    print("수신 실패: \(error!.localizedDescription)" )
//                    return
//                }
//
//                if let safeData = data {
//                    do {
//                        let decodedData = try JSONDecoder().decode(Movies.self, from: safeData)
//                        completion(.success(decodedData))
//                    } catch {
//                        print("데이터 수신 실패: \(error.localizedDescription)")
//                    }
//                }
//            }
//            dataTask.resume()
//        }
//    }
}
