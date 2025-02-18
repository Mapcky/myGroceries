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
    
    func addItemToCart(productId: Int, quantity: Int) async throws {
        let body = ["productId" : productId, "quantity" : quantity]
        
        let bodyData = try JSONEncoder().encode(body)
        
        let resource = Resource(url: Constants.Urls.addCartItem, method: .post(bodyData), modelType: CartItemResponse.self)
        
        let response = try await httpClient.load(resource)
        
        if response.success {
            
        } else {
            
        }
        
    }
    
}
