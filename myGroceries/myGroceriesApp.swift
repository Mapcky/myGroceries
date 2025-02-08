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
    
    var body: some Scene {
        WindowGroup {
                HomeScreen()
                .environment(\.authenticationController, .development)
                .environment(productStore)
        }
    }
}
