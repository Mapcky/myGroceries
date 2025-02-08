//
//  ProductCellView.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 07/02/2025.
//

import SwiftUI

struct ProductCellView: View {
    
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: product.photoUrl) { img in
                img.resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            } placeholder: {
                ProgressView("Loading...")
            }
            Text(product.name)
                .font(.title)
            
            Text(product.price, format: .currency(code: "USD"))
                .font(.title2)
        }
        .padding()
    }
}

#Preview {
    ProductCellView(product: Product(id: 1, description: "hihi", name: "chair", price: 200, photoUrl: nil, userId: 1))
}
