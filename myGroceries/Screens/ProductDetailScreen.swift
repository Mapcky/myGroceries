//
//  ProductDetailScreen.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 18/02/2025.
//

import SwiftUI

struct ProductDetailScreen: View {
    // MARK: - PROPERTIES
    
    let product: Product
    @Environment(CartStore.self) private var cartStore
    @State private var message:String = ""
    @State private var quantity: Int = 1
    
    // MARK: - FUNCTIONS
    
    private func addToCart() async {
        do {
            try await cartStore.addItemToCart(productId: product.id!, quantity: quantity)
        } catch {
            message = error.localizedDescription
        }
    }
    
    // MARK: - BODY
    var body: some View {
        ScrollView {
            AsyncImage(url: product.photoUrl) { img in
                img.resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    .scaledToFit()
            } placeholder: {
                ProgressView("Loading...")
            }
            
            Text(product.name)
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(product.description)
                .padding(.top, 5)
            
            Text(product.price, format: .currency(code: "USD"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .bold()
                .padding(.top, 2)
            
            Stepper(value: $quantity,in: 1...100, label: {
                Text("Quantity: \(quantity)")
            })
            
            Button(action: {
                Task {
                    await addToCart()
                }
            }, label: {
                Text("Add to cart")
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .foregroundStyle(.white)
                    .background(.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            })
        }//: SCROLL
        .padding()
    }
}

#Preview {
    ProductDetailScreen(product: Product(id: 6, description: "Tiger", name: "Tenori", price: 55, photoUrl: URL(string:"http://localhost:8080/api/uploads/image-1739539153351.png"), userId: 1))
        .environment(CartStore(httpClient: .development))
}
