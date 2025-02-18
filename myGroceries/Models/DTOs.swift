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
    
    var id: Int?
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
    
    func encode() -> Data? {
        try? JSONEncoder().encode(self)
    }
    
}

struct CreateProductResponse: Codable {
    let success: Bool
    let product: Product?
    let message: String?
}

struct UploadDataResponse: Codable {
    let success: Bool
    let message: String?
    let downloadURL: URL?
    
    private enum CodingKeys: String, CodingKey {
        case message, success
        case downloadURL = "downloadUrl"
    }
}

struct DeleteProductResponse: Codable {
    let success: Bool
    let message: String?
}

struct UpdateProductResponse: Codable {
    let success: Bool
    let message: String?
    let product: Product?
}

struct ErrorResponse: Codable {
    let message: String?
}

struct Cart: Codable {
    let id: Int?
    let userId: Int
    var cartItems: [CartItem] = []
    
    private enum CodingKeys: String, CodingKey {
        case id, cartItems
        case userId = "user_id"
    }
}

struct CartItem: Codable, Identifiable {
    let id: Int?
    let product: Product
    var quantity: Int = 1
}


struct CartItemResponse: Codable {
    let message: String?
    let success: Bool
}
