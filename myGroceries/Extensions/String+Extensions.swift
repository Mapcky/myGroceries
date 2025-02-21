//
//  String+Extensions.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 05/02/2025.
//

import Foundation

extension String {
    
    var isEmptyOrWhiteSpaces: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var isZipCode: Bool {
        // Adjust this regex for your ZIP code requirements (US format example here)
        let zipCodeRegex = "^[0-9]{4}(-[0-9]{4})?$"
        return NSPredicate(format: "SELF MATCHES %@", zipCodeRegex).evaluate(with: self)
    }
}
