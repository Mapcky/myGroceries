//
//  myGroceriesApp.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 04/02/2025.
//

import SwiftUI
@preconcurrency import Stripe

@main
struct myGroceriesApp: App {
    // MARK: - PROPERTIES
    
    @State private var productStore = ProductStore(httpClient: HTTPClient())
    @State private var cartStore = CartStore(httpClient: HTTPClient())
    @State private var userStore = UserStore(httpClient: HTTPClient())
    @State private var paymentController = PaymentController(httpClient: HTTPClient())
    @State private var orderStore = OrderStore(httpClient: HTTPClient())
    
    @AppStorage("userId") private var userId: String?
    
    init() {
        StripeAPI.defaultPublishableKey = ProcessInfo.processInfo.environment["STRIPE_PUBLISHABLE_KEY"] ?? ""
    }
    
    // MARK: - FUNCTIONS
    private func loadUserInfoAndCart() async {
        do {
            try await userStore.loadUserInfo()
            try await cartStore.loadCart()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - BODY
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environment(\.authenticationController, .development)
                .environment(productStore)
                .environment(cartStore)
                .environment(userStore)
                .environment(orderStore)
                .environment(\.paymentController, paymentController)
                .environment(\.uploaderDownloader, UploaderDownloader(httpClient: HTTPClient()))
                .task(id: userId) {
                    if userId != nil {
                        await loadUserInfoAndCart()
                    }
                }
        }
    }
}
