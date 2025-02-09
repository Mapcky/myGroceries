//
//  RegistrationScreen.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 05/02/2025.
//

import SwiftUI

struct RegistrationScreen: View {
    // MARK: - PROPERTIES
    @Environment(\.authenticationController) private var authenticationController
    @Environment(\.dismiss) private var dismiss
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var message: String = ""
    
    // MARK: - FUNCTIONS
    
    private func register() async {
        do {
            let response = try await authenticationController.register(username: username, password: password)
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
        !username.isEmptyOrWhiteSpaces && !password.isEmptyOrWhiteSpaces
    }
    var body: some View {
        Form {
            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
            Button("Register") {
                Task {
                    await register()
                }
            }.disabled(!isFormValid)
            Text(message)
        }.navigationTitle("Register")
    }
}

#Preview {
    NavigationStack {
        RegistrationScreen()
    }.environment(\.authenticationController, .development)
}
