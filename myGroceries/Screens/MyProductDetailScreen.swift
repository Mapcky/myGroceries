//
//  MyProductDetailScreen.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 12/02/2025.
//

import SwiftUI

struct MyProductDetailScreen: View {
    // MARK: - PROPERTIES
    @Environment(ProductStore.self) private var productStore
    @Environment(\.dismiss) private var dismiss
    let product: Product
    
    // MARK: - FUNCTIONS
    
    private func deleteProduct() async {
        do {
            try await productStore.deleteProduct(product)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    // MARK: - BODY
    var body: some View {
        ScrollView(showsIndicators: false, content: {
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
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(product.price, format: .currency(code: "USD"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .bold()
                .padding(.top, 2)
            
            Button(role: .destructive) {
                Task {
                    await deleteProduct()
                    dismiss()
                }
            } label: {
                Text("Delete")
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
            }.buttonStyle(.borderedProminent)
            
            
        }).padding()
    }
}

#Preview {
    NavigationStack{
        MyProductDetailScreen(product: Product(description: "", name: "casa", price: 200, photoUrl: nil, userId: 1))
    }.environment(ProductStore(httpClient: .development))
}
