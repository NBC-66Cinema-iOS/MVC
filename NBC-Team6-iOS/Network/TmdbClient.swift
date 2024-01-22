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
    private func createURL(endpoint: String) -> URL? {
        let urlString = "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)"
        return URL(string: urlString)
    }
    
    func fetchUpcomingMovies(completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        // URLRequest 생성
        guard let url = createURL(endpoint: "upcoming") else {
            print("Invalid URL")
            return
        }
        
        networkManager.request(url: url) { result in
            self.handleMovieResponse(result: result, completion: completion)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        // 요청 로깅
        NetworkLogger.log(request: urlRequest)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            // 응답 로깅
            NetworkLogger.log(response: response, data: data, error: error)
            
            // 응답 처리
        }
        task.resume()
    }
    
    func fetchNowPlayingMovies(completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        guard let url = createURL(endpoint: "now_playing") else {
            return
        }
        
        networkManager.request(url: url) { result in
            self.handleMovieResponse(result: result, completion: completion)
        }
    }
    
    func fetchPopularMovies(completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        guard let url = createURL(endpoint: "popular") else {
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
    
    func fetchMovieImageURL(from imagePath: String) -> URL? {
        // 이미지 기본 URL (예: https://image.tmdb.org/t/p/w500/)
        let baseURL = "https://image.tmdb.org/t/p/w500/"

        // 상대 경로를 절대 경로로 변환
        let absoluteURLString = baseURL + imagePath

        // URL 형식으로 반환
        return URL(string: absoluteURLString)
    }
}
