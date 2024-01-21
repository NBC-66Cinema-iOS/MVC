//
//  NetworkLogger.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/16.
//

import Foundation

class NetworkLogger {
    static func log(request: URLRequest) {
        print("----------------------------------------------------")
        print("1️⃣ Request:\nURL: \(request.url?.absoluteString ?? "nil")\nHTTP method: \(request.httpMethod ?? "nil")\nHeaders: \(request.allHTTPHeaderFields ?? [:])")
        if let body = request.httpBody {
            print("Body: \(String(data: body, encoding: .utf8) ?? "nil")")
        }
        print("----------------------------------------------------")
    }
    
    static func log(response: URLResponse?, data: Data?, error: Error?) {
        print("----------------------------------------------------")
        print("2️⃣ Response:")
        if let httpResponse = response as? HTTPURLResponse {
            print("URL: \(httpResponse.url?.absoluteString ?? "nil")\nStatus code: \(httpResponse.statusCode)\nHeaders: \(httpResponse.allHeaderFields)")
        }
        if let data = data {
            print("Data: \(String(data: data, encoding: .utf8) ?? "nil")")
        }
        if let error = error {
            print("Error: \(error)")
        }
        print("----------------------------------------------------")
    }
}
