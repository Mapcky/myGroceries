//
//  CartItemView.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 19/02/2025.
//

import SwiftUI

struct CartItemView: View {
    // MARK: - PROPERTIES
    let cartItem: CartItem
    // MARK: - BODY
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: cartItem.product.photoUrl) { img in
                img.resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView("Loading...")
            }
            Spacer()
                .frame(width: 20)
            VStack(alignment: .leading, content: {
                Text(cartItem.product.name)
                    .font(.title3)
                Text(cartItem.product.price, format: .currency(code: "USD"))
                
                CartItemQuantityView(cartItem: cartItem)
            }).frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    CartItemView(cartItem: CartItem(id: 1, product: Product(description: "Big Table", name: "Table", price: 222, photoUrl: nil, userId: 1), quantity: 20))
        .environment(CartStore(httpClient: .development))
}
