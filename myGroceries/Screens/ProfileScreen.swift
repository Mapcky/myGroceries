//
//  ProfileScreen.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 06/02/2025.
//

import SwiftUI

struct ProfileScreen: View {
    // MARK: - PROPERTIES
    @AppStorage("userId") private var userId: Int?
    @Environment(CartStore.self) private var cartStore
    @Environment(UserStore.self) private var userStore
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var street: String = ""
    @State private var city: String = ""
    @State private var state: String = ""
    @State private var zipCode: String = ""
    @State private var country: String = ""
    
    @State private var validationErrors: [String] = []
    @State private var updatingUserInfo: Bool = false
    // MARK: - FUNCTIONS
    private func validateForm() -> Bool {
        
        validationErrors = []
        
        if firstName.isEmptyOrWhiteSpaces {
            validationErrors.append("First name is required.")
        }
        
        if lastName.isEmptyOrWhiteSpaces {
            validationErrors.append("Last name is required.")
        }
        if street.isEmptyOrWhiteSpaces {
            validationErrors.append("Street is required.")
        }
        if city.isEmptyOrWhiteSpaces {
            validationErrors.append("City is required.")
        }
        if state.isEmptyOrWhiteSpaces {
            validationErrors.append("State is required.")
        }
        if !zipCode.isZipCode {
            validationErrors.append("Invalid ZIP code.")
        }
        if country.isEmptyOrWhiteSpaces {
            validationErrors.append("Country is required.")
        }
        
        return validationErrors.isEmpty
    }
    
    private func updateUserInfo() async {
        do {
            let userInfo = UserInfo(firstName: firstName, lastName: lastName, street: street, city: city, state: state, zipCode: zipCode, country: country)
            
            try await userStore.updateUserInfo(userInfo: userInfo)
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    // MARK: - BODY
    var body: some View {
        List {
            Section("Personal Information") {
                TextField("First name", text: $firstName)
                TextField("Last name", text: $lastName)
            }
            
            Section("Address") {
                TextField("Street", text: $street)
                TextField("City", text: $city)
                TextField("State", text: $state)
                TextField("Zipcode", text: $zipCode)
                TextField("Country", text: $country)
            }
            
            ForEach(validationErrors, id: \.self) { errorMessage in
                Text(errorMessage)
            }
            
            Button("Signout") {
                let _ = Keychain<String>.delete("jwttoken")
                userId = nil
                cartStore.emptyCart()
            }
        }
        .onChange(of: userStore.userInfo, initial: true, {
            if let userInfo = userStore.userInfo {
                firstName = userInfo.firstName ?? ""
                lastName = userInfo.lastName ?? ""
                street = userInfo.street ?? ""
                city = userInfo.city ?? ""
                state = userInfo.state ?? ""
                zipCode = userInfo.zipCode ?? ""
                country = userInfo.country ?? ""
            }
        })
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    if validateForm() {
                        updatingUserInfo = true
                    }
                }
            }
        }.task(id: updatingUserInfo) {
            if updatingUserInfo {
                await updateUserInfo()
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProfileScreen()
            .environment(CartStore(httpClient: .development))
            .environment(UserStore(httpClient: .development))
    }
}
