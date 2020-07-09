//
//  User.swift
//  RealWorldSwift
//
//  Created by Erdem Koçer on 9.07.2020.
//  Copyright © 2020 Erdem Koçer. All rights reserved.
//

import Foundation


struct Userbody: Codable {
    let user: User
}

struct User: Codable {
    let id: Int
    let email: String
    let createdAt: String
    let updatedAt: String
    let username: String
    let bio: String
    let image: String
    let token: String
}
