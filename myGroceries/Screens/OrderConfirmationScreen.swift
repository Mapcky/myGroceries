//
//  OrderConfirmationScreen.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 07/03/2025.
//

import SwiftUI

struct OrderConfirmationScreen: View {
    var body: some View {
        VStack(spacing: 20) {
            
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundStyle(.green)
            
            Text("Order Placed Succesfully")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("Thank you for your purchase! Your order has been successfully placed. We are preparing it for shipment.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding(.horizontal, 20)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Order Confirmed")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    OrderConfirmationScreen()
}
