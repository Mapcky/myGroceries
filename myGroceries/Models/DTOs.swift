//
//  DTOs.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 05/02/2025.
//

import Foundation

struct RegisterResponse: Codable {
    let message: String?
    let success: Bool
}

struct LoginResponse: Codable {
    let message: String?
    let token: String?
    let success: Bool
    let userId: Int?
    let username: String?
}

struct Product: Codable, Identifiable {
    
    var id: Int
    let description: String
    let name: String
    let price: Double
    let photoUrl: URL?
    let userId: Int
    
    private enum CodingKeys: String, CodingKey {
        case id, name, description, price
        case photoUrl = "photo_url"
        case userId = "user_id"
    }
    
}

struct ErrorResponse: Codable {
    let message: String?
}
