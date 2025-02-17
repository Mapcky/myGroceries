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
    @State private var message: String?
    
    // MARK: - FUNCTIONS
    private func loadMyProducts() async {
        do {
            guard let userId = userId else {
                throw UserError.missingId
            }
            try await productStore.loadMyProducts(by: userId)
        } catch {
            message = error.localizedDescription
        }
    }
    
    // MARK: - BODY
    var body: some View {
        List(productStore.myProducts) { product in
            NavigationLink(destination: {
                MyProductDetailScreen(product: product)
            }, label: {
                MyProductCellView(product: product)
            })
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
        .overlay(alignment: .center) {
            
            if let message {
                Text("Failed to process request. Please make sure to sign in.")
            } else if productStore.myProducts.isEmpty {
                ContentUnavailableView("No Products Available.", systemImage: "star.fill")
            }
        }
    }
}

struct MyProductCellView: View {
    
    let product: Product
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: product.photoUrl) { img in
                img.resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView("Loading...")
            }
            Spacer()
                .frame(width: 20)
            VStack {
                Text(product.name)
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(product.price, format: .currency(code: "USD"))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    NavigationStack {
        MyProductListScreen()
    }.environment(ProductStore(httpClient: .development))
}
