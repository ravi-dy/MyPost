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

struct CommentModel: Decodable {

    let postId: Int
    let identifier: Int
    let name: String
    let email: String
    let body: String

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case postId
        case name
        case email
        case body
    }
}

