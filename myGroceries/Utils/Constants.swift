//
//  Constants.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 05/02/2025.
//

import Foundation

struct Constants {
    
    struct Urls {
        static let register: URL = URL(string: "http://localhost:8080/api/auth/register")!
        static let login: URL = URL(string: "http://localhost:8080/api/auth/login")!
        static let products: URL = URL(string: "http://localhost:8080/api/products")!
        static let createProducts: URL = URL(string: "http://localhost:8080/api/products")!
        static let uploadProductImage: URL = URL(string: "http://localhost:8080/api/products/upload")!
        static let addCartItem: URL = URL(string: "http://localhost:8080/api/cart/items")!
        static let loadCart: URL = URL(string: "http://localhost:8080/api/cart")!
        static let updateUserInfo: URL = URL(string: "http://localhost:8080/api/user/update")!
        static let loadUserInfo: URL = URL(string: "http://localhost:8080/api/user")!
        static let createPaymentIntent: URL = URL(string: "http://localhost:8080/api/payment/create-payment-intent")!

        
        static func myProducts(_ userId: Int) -> URL {
            URL(string: "http://localhost:8080/api/products/user/\(userId)")!
        }
        
        static func deleteProducts(_ productId: Int) -> URL {
            URL(string: "http://localhost:8080/api/products/\(productId)")!
        }
        
        static func updateProducts(_ productId: Int) -> URL {
            URL(string: "http://localhost:8080/api/products/\(productId)")!
        }
        
        static func deleteCartItem(_ cartItemId: Int) -> URL {
            URL(string: "http://localhost:8080/api/cart/item/\(cartItemId)")!
        }
    }
}
