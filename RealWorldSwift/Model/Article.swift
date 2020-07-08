//
//  Article.swift
//  RealWorldSwift
//
//  Created by Erdem Koçer on 9.07.2020.
//  Copyright © 2020 Erdem Koçer. All rights reserved.
//

import Foundation

struct Welcome: Codable {
    let articles: [Article]
    let articlesCount: Int?
}

struct Article: Codable {
    let title: String?
    let slug: String?
    let body: String?
    let createdAt, updatedAt: String?
    let tagList: [String]?
    let description: String?
    let author: Author?
    let favorited: Bool?
    let favoritesCount: Int?

    enum CodingKeys: String, CodingKey {
        case title, slug, body, createdAt, updatedAt, tagList
        case description
        case author, favorited, favoritesCount
    }
}

struct Author: Codable {
    let username: String?
    let bio: String?
    let image: String?
    let following: Bool?
}
