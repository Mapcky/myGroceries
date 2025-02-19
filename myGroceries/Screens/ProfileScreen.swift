//
//  ProfileScreen.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 06/02/2025.
//

import SwiftUI

struct ProfileScreen: View {
    // MARK: - PROPERTIES
    @AppStorage("userId") private var userId: String?
    @Environment(CartStore.self) private var cartStore
    // MARK: - FUNCTIONS
    
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Text("Profile")
            
            Button("SignOut") {
                let _ = Keychain<String>.delete("jwttoken")
                userId = nil
                cartStore.emptyCart()
            }
        }
    }
}

#Preview {
    ProfileScreen()
        .environment(CartStore(httpClient: .development))
}
