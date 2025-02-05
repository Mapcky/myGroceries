//
//  AuthenticationEnvironmentKey.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 05/02/2025.
//

import Foundation
import SwiftUI

private struct AuthenticationEnvironmentKey: EnvironmentKey {
    static let defaultValue: AuthenticationController = AuthenticationController(httpClient: HTTPClient())
}

extension EnvironmentValues {
    
    var authenticationController: AuthenticationController {
        get { self[AuthenticationEnvironmentKey.self] }
        set { self[AuthenticationEnvironmentKey.self] = newValue }
    }
    
}
