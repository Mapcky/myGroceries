//
//  ProductListScreen.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 07/02/2025.
//

import SwiftUI

struct ProductListScreen: View {
    
    @Environment(ProductStore.self) private var productStore
    
    var body: some View {
        List(productStore.products) { product in
            NavigationLink(destination: {
                ProductDetailScreen(product: product)
            }, label: {
                ProductCellView(product: product)
                    .listRowSeparator(.hidden)
            })
            .navigationTitle("New Arrivals")
            .listStyle(.plain)
        }.task {
            do {
                try await productStore.loadAllProducts()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProductListScreen()
    }.environment(ProductStore(httpClient: .development))
        .environment(CartStore(httpClient: .development))
}
