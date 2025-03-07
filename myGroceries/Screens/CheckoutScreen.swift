//
//  CheckoutScreen.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 06/03/2025.
//

import SwiftUI

struct CheckoutScreen: View {
    // MARK: - PROPERTIES
    
    let cart: Cart
    
    @Environment(UserStore.self) private var userStore
    
    // MARK: - BODY
    var body: some View {
        List {
            VStack(spacing: 10) {
                Text("Place your order")
                    .font(.title3)
                
                HStack {
                    Text("Items: ")
                    Spacer()
                    Text(cart.total, format: .currency(code: "USD"))
                }//: HSTACK
                
                if let userInfo = userStore.userInfo {
                    Text("Delivering to \(userInfo.fullName)")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("\(userInfo.address)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    Text("Please update your profile and add the missing information.")
                        .foregroundStyle(.red)
                }
                
            }//: VSTACK
            .padding()
            
            ForEach(cart.cartItems) { item in
                CartItemView(cartItem: item)
            }
        }//: LIST
    }
}

#Preview {
    NavigationStack {
        CheckoutScreen(cart: Cart(userId: 1))
    }
    .environment(UserStore(httpClient: .development))
    .environment(CartStore(httpClient: .development))
}
