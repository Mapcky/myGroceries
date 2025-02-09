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
}
