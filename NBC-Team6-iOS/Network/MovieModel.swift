//
//  MovieModel.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/21.
//

import UIKit

struct MovieModel: Decodable {
    let imagePath: String?
    let title: String
    let overview: String
    
    var absoluteImagePath: String {
        let baseURL = "https://image.tmdb.org/t/p/w500"
        return baseURL + (imagePath ?? "")
    }

    enum CodingKeys: String, CodingKey {
        case imageURLString = "poster_path"
        case title
        case overview
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imagePath = try container.decode(String.self, forKey: .imageURLString)
        self.title = try container.decode(String.self, forKey: .title)
        self.overview = try container.decode(String.self, forKey: .overview )
    }
}

