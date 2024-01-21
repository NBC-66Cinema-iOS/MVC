//
//  MovieModel.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/21.
//

import UIKit

struct MovieModel: Codable {
    let imageURLString: String?
    let title: String

    enum CodingKeys: String, CodingKey {
        case imageURLString = "poster_path"
        case title
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageURLString = try container.decode(String.self, forKey: .imageURLString)
        self.title = try container.decode(String.self, forKey: .title)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(imageURLString, forKey: .imageURLString)
        try container.encode(title, forKey: .title)
    }
}

