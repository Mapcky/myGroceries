//
//  CartItemQuantityView.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 19/02/2025.
//

import SwiftUI

enum QuantityChangeType: Equatable {
    case update(Int)
    case delete
}

struct CartItemQuantityView: View {
    // MARK: - PRORPERTIES
    
    let cartItem: CartItem
    @State private var quantity: Int = 0
    @State private var quantityChangeType: QuantityChangeType?
    @Environment(CartStore.self) private var cartStore
    
    // MARK: - BODY
    var body: some View {
        HStack {
            Button(action: {
                
                if quantity == 1 {
                    quantityChangeType = .delete
                } else {
                    quantity -= 1
                    quantityChangeType = .update(-1)
                }
                
            }, label: {
                Image(systemName: cartItem.quantity == 1 ? "trash" : "minus")
                    .frame(width: 24, height: 24)
            })
            
            Text("\(cartItem.quantity)")

            Button(action: {
                quantity += 1
                quantityChangeType = .update(1)
            }, label: {
                Image(systemName: "plus")
                    .frame(width: 24, height: 24)
            })
        }
        .task(id: quantityChangeType) {
            if let quantityChangeType {
                switch quantityChangeType {
                case .update(let quantity):
                    do {
                        try await cartStore.updateItemQuantity(productId: cartItem.product.id!, quantity: quantity)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .delete:
                    do {
                        try await cartStore.deleteCartItem(cartItemId: cartItem.id!)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
            self.quantityChangeType = nil
        }
        .onAppear() {
            quantity = cartItem.quantity
        }
        .frame(width: 150)
        .background(.gray)
        .foregroundStyle(.white)
        .buttonStyle(.borderedProminent)
        .tint(.gray)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    CartItemQuantityView(cartItem: CartItem(id: 1, product: Product(description: "Big Table", name: "Table", price: 222, photoUrl: nil, userId: 1), quantity: 2))
        .environment(CartStore(httpClient: .development))
}
