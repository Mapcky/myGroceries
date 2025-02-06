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

struct ErrorResponse: Codable {
    let message: String?
}
