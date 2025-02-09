//
//  Errors.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 08/02/2025.
//

import Foundation

enum ProductSaveError: Error {
    case missingUserId
    case invalidPrice
    case operationFailed(String)
    case missingImage
}

enum UserError: Error {
    case missingId
}
