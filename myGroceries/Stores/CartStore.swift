//
//  CartStore.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 18/02/2025.
//

import Foundation

@MainActor
@Observable
class CartStore {
    
    let httpClient: HTTPClient
    var cart: Cart?
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    var itemsCount: Int {
        cart?.cartItems.reduce(0, { total, cartItem in
            total + cartItem.quantity
        }) ?? 0
    }
    
    var total: Double {
        cart?.cartItems.reduce(0.0, { total, cartItem in
            total + (cartItem.product.price * Double(cartItem.quantity))
        }) ?? 0.0
    }
    
    
    func loadCart() async throws {
        let resource = Resource(url: Constants.Urls.loadCart, modelType: CartResponse.self)
        
        let response = try await httpClient.load(resource)
        
        if let cart = response.cart, response.success {
            self.cart = cart
        } else {
            throw CartError.operationFailed(response.message ?? "Operation Failed")
        }
    }
    
    func addItemToCart(productId: Int, quantity: Int) async throws {
        let body = ["productId" : productId, "quantity" : quantity]
        
        let bodyData = try JSONEncoder().encode(body)
        
        let resource = Resource(url: Constants.Urls.addCartItem, method: .post(bodyData), modelType: CartItemResponse.self)
        
        let response = try await httpClient.load(resource)
        
        if let cartItem = response.cartItem, response.success {
            // initialize the cart if it is nil
            if cart == nil {
                guard let userId = UserDefaults.standard.userId else { throw UserError.missingId }
                cart = Cart(userId: userId)
            }
            
            // if item already in cart then update it
            if let index = cart?.cartItems.firstIndex(where: { $0.id == cartItem.id }) {
                cart?.cartItems[index] = cartItem
            } else {
                // add new item
                cart?.cartItems.append(cartItem)
            }
        } else {
            throw CartError.operationFailed(response.message ?? "Operation Failed")
        }
        
    }
    
}
