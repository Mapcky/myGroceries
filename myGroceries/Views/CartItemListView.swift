//
//  CartItemListView.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 19/02/2025.
//

import SwiftUI

struct CartItemListView: View {
    // MARK: - PROPERTIES
    let cartItems: [CartItem]
    // MARK: - BODY
    var body: some View {
        ForEach(cartItems) { cartItem in
            CartItemView(cartItem: cartItem)
        }.listStyle(.plain)
    }
}

#Preview {
    CartItemListView(cartItems: [])
}
