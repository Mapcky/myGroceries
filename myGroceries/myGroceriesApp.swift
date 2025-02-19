//
//  myGroceriesApp.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 04/02/2025.
//

import SwiftUI

@main
struct myGroceriesApp: App {
    // MARK: - PROPERTIES

    @State private var productStore = ProductStore(httpClient: HTTPClient())
    @State private var cartStore = CartStore(httpClient: HTTPClient())
    
    @AppStorage("userId") private var userId: String?
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environment(\.authenticationController, .development)
                .environment(productStore)
                .environment(cartStore)
                .environment(\.uploaderDownloader, UploaderDownloader(httpClient: HTTPClient()))
                .task(id: userId) {
                    do {
                        if userId != nil {
                            try await cartStore.loadCart()
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
        }
    }
}
