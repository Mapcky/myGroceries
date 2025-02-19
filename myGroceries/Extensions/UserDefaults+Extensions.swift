//
//  UserDefaults+Extensions.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 18/02/2025.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let userId = "userId"
    }
    
    var userId: Int? {
        get {
            let id = integer(forKey: Keys.userId)
            return id == 0 ? nil : id
        }
        set {
            set(newValue, forKey: Keys.userId)
        }
    }
}
