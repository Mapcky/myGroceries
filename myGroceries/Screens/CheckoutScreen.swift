//
//  CheckoutScreen.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 06/03/2025.
//

import SwiftUI
import StripePaymentSheet

struct CheckoutScreen: View {
    // MARK: - PROPERTIES
    
    let cart: Cart
    
    @Environment(\.paymentController) private var paymentController
    @Environment(UserStore.self) private var userStore
    @State private var paymentSheet: PaymentSheet?
    
    // MARK: - FUNCTIONS
    
    private func paymentCompletion(result: PaymentSheetResult) {
        print(result)
    }
    
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
            
            if let paymentSheet {
                PaymentSheet.PaymentButton(paymentSheet: paymentSheet, onCompletion: paymentCompletion) {
                    Text("Place your order")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.green)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding()
                        .buttonStyle(.borderless)
                    
                }
            }
            
        }//: LIST
        .task {
            do {
                paymentSheet = try await paymentController.preparePaymentSheet(for: cart)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    NavigationStack {
        CheckoutScreen(cart: Cart(userId: 1))
    }
    .environment(UserStore(httpClient: .development))
    .environment(CartStore(httpClient: .development))
    .environment(\.paymentController, PaymentController(httpClient: .development))
}
