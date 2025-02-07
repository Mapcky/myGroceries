//
//  RequiresAuthentication.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 06/02/2025.
//

import Foundation
import SwiftUI

struct RequiresAuthentication: ViewModifier {
    
    @State private var isLoading: Bool = true
    @AppStorage("userId") private var userId: String?
    
    func body(content: Content) -> some View {
        Group {
            if isLoading {
                ProgressView("Loading...")
            } else {
                if userId != nil {
                    content
                } else {
                    LoginScreen()
                }
            }
        }.onAppear(perform: {
            checkAuthentication()
        })
    }
    
    private func checkAuthentication() {
        guard let token = Keychain<String>.get("jwttoken"), JWTTokenValidator.validate(token: token) else {
            isLoading = false
            userId = nil
            return
        }
        
        isLoading = false
    }
}

extension View {
    func requiresAuthentication() -> some View {
        modifier(RequiresAuthentication())
    }
}
