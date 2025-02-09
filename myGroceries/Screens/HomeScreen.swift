//
//  HomeScreen.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 06/02/2025.
//

import SwiftUI

enum AppScreen: Hashable, Identifiable, CaseIterable {
    case home
    case myProducts
    case cart
    case profile
    
    var id: AppScreen { self }
}

extension AppScreen {
    
    @ViewBuilder
    var label: some View {
        switch self {
        case .home:
            Label("Home", systemImage: "heart.fill")
        case .myProducts:
            Label("My Products", systemImage: "star")
        case .cart:
            Label("Cart", systemImage: "cart")
        case .profile:
            Label("Profile", systemImage: "person.fill")
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .home:
            ProductListScreen()
        case .myProducts:
            MyProductListScreen()
        case .cart:
            Text("Cart")
        case .profile:
            ProfileScreen()
        }
    }
    
}

struct HomeScreen: View {
    
    @State var selection: AppScreen?
    var body: some View {
        TabView(selection: $selection) {
            ForEach(AppScreen.allCases) { screen in
                screen.destination
                    .tag(screen as AppScreen?)
                    .tabItem {screen.label}
            }
        }
        .requiresAuthentication()
    }
}

#Preview {
    NavigationStack {
        HomeScreen()
            .environment(ProductStore(httpClient: .development))
    }
}
