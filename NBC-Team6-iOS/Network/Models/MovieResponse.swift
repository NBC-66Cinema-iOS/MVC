//
//  MovieResponse.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/21.
//

import Foundation

struct MovieResponse: Codable {
//    let dates: Dates
//    let page: Int
    let results: [MovieModel]
}

struct Dates: Codable {
    let maximum: String
    let minimum: String
}
