//
//  NetworkManager.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/21.
//

import Foundation

class NetworkManager {
    private var urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func request(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
}

