//
//  Errors.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 08/02/2025.
//

import Foundation

enum ProductError: Error {
    case missingUserId
    case invalidPrice
    case operationFailed(String)
    case missingImage
    case uploadFailed(String)
    case productNotFound
}

enum UserError: Error {
    case missingId
}


enum CartError: Error {
    case operationFailed(String)
}
