//
//  Model.swift
//  MyPosts
//

import Foundation

struct PostModel: Decodable {
    let identifier: Int
    let userId: Int
    let title: String
    let body: String

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case userId
        case title
        case body
    }
}


