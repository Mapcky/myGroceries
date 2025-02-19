//
//  CartScreen.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 19/02/2025.
//

import SwiftUI

struct CartScreen: View {
    // MARK: - PROPERTIES
    
    @Environment(CartStore.self) private var cartStore
    
    // MARK: - BODY
    var body: some View {
        List {
            if let cart = cartStore.cart {
                HStack {
                    Text("Total: ")
                        .font(.title)
                    Text(cartStore.total, format: .currency(code: "USD"))
                        .font(.title)
                        .bold()
                }
                
                Button(action: {
                    
                },
                       label: {
                    Text("Proceed to checkout ^[(\(cartStore.itemsCount) Item](inflect: true))")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.green)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                })
                .buttonStyle(.borderless)
                
                CartItemListView(cartItems: cart.cartItems)
            } else {
                ContentUnavailableView("No items in the cart.", systemImage: "cart")
            }
        }.task {
            try? await cartStore.loadCart()
        }
    }
}

#Preview {
    CartScreen()
        .environment(CartStore(httpClient: .development))
}
