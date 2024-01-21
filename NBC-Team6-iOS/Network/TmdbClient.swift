//
//  TmdbClient.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/21.
//

import UIKit

class TMDBClient {
    private var networkManager: NetworkManager
    private let apiKey = "9ca2b73188bb1e359706aebc73f43d55"
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
        
    }
}

extension TMDBClient {
    func fetchUpcomingMovies(completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        // URLRequest 생성
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)") else {
            print("Invalid URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        // 요청 로깅
        NetworkLogger.log(request: urlRequest)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            // 응답 로깅
            NetworkLogger.log(response: response, data: data, error: error)
            
            // 응답 처리
            // ...
        }
        task.resume()
    }
    
    func fetchNowPlayingMovies(completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)") else {
            return
        }
        
        networkManager.request(url: url) { result in
            self.handleMovieResponse(result: result, completion: completion)
        }
    }
    
    func fetchPopularMovies(completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)") else {
            return
        }
        
        networkManager.request(url: url) { result in
            self.handleMovieResponse(result: result, completion: completion)
        }
    }
    
    private func handleMovieResponse(result: Result<Data, Error>, completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        switch result {
        case .success(let data):
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MovieResponse.self, from: data)
                completion(.success(response.results))
            } catch {
                completion(.failure(error))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
