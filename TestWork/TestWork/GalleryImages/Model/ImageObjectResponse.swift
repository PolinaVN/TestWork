//
//  ImageObjectResponse.swift
//  TestWork
//
//  Created by Polina on 09.03.2022.
//

import Foundation

// MARK: - ImageObjectResponse
struct ImageObjectResponse: Codable {
    let id: String
    let createdAt: String
    let welcomeDescription: String?
    let urls: Urls
    let likes: Int
    let width, height: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case welcomeDescription = "description"
        case urls
        case likes
        case width
        case height
    }
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb, smallS3: String
    
    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}
