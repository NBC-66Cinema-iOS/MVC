//
//  MovieModel.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/21.
//

import UIKit

struct MovieModel: Codable {
    let image: URL?
    let title: String

    enum CodingKeys: String, CodingKey {
        case image = "poster_path"
        case title
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let imagePath = try container.decode(String.self, forKey: .image)
        self.image = URL(string: "https://image.tmdb.org/t/p/w500" + imagePath)
        self.title = try container.decode(String.self, forKey: .title)
    }
}
