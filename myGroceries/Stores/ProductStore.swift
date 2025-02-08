//
//  ProductStore.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 07/02/2025.
//

import Foundation
import Observation

@Observable
class ProductStore {
    
    let httpClient: HTTPClient
    private(set) var products: [Product] = []
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func loadAllProducts() async throws {
        let resource = Resource(url: Constants.Urls.products, modelType: [Product].self)
        products = try await httpClient.load(resource)
    }
    
}
