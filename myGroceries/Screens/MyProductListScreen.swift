//
//  MyProductListScreen.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 09/02/2025.
//

import SwiftUI

struct MyProductListScreen: View {
    // MARK: - PROPERTIES
    @State private var isPresented: Bool = false
    @Environment(ProductStore.self) private var productStore
    @AppStorage("userId") private var userId: Int?
    
    // MARK: - FUNCTIONS
    private func loadMyProducts() async {
        do {
            guard let userId = userId else {
                throw UserError.missingId
            }
            try await productStore.loadMyProducts(by: userId)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - BODY
    var body: some View {
        List(productStore.myProducts) { product in
            Text(product.name)
        }
        .task {
            await loadMyProducts()
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing, content: {
                Button("Add Product") {
                    isPresented = true
                }
            })
        })
        .sheet(isPresented: $isPresented, content: {
            NavigationStack {
                AddProductScreen()
            }
        })
    }
}

#Preview {
    NavigationStack {
        MyProductListScreen()
    }.environment(ProductStore(httpClient: .development))
}
