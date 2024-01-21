//
//  MovieResponse.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/21.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [MovieModel]
}
