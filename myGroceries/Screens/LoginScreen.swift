//
//  LoginScreen.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 06/02/2025.
//

import SwiftUI

struct LoginScreen: View {
    // MARK: - PROPERTIES
    @Environment(\.authenticationController) private var authenticationController
    @Environment(\.dismiss) private var dismiss
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var message: String = ""
    
    @AppStorage("userId") private var userId: Int?
    
    // MARK: - FUNCTIONS
    
    private func login() async {
        do {
            let response = try await authenticationController.login(username: username, password: password)
            
            guard let token = response.token,
                  let userId = response.userId, response.success else {
                
                message = response.message ?? "Request cannot be completed"
                return
            }
            Keychain.set(token, forKey: "jwttoken")
            
            self.userId = userId
            
            if response.success {
                dismiss()
            } else {
                message = response.message ?? ""
            }
        } catch {
            message = error.localizedDescription
        }
        username = ""
        password = ""
    }
    
    private var isFormValid: Bool {
        !username.isEmptyOnWhiteSpaces && !password.isEmptyOnWhiteSpaces
    }
    var body: some View {
        Form {
            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
            Button("Login") {
                Task {
                    await login()
                }
            }.disabled(!isFormValid)
            Text(message)
        }
        .navigationTitle("Login")
    }
}

#Preview {
    NavigationStack {
        LoginScreen()
    }.environment(\.authenticationController, .development)
}
