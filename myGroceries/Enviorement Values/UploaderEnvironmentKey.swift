//
//  UploaderEnvironmentKey.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 10/02/2025.
//

import Foundation
import SwiftUI

private struct UploaderEnvironmentKey: EnvironmentKey {
    static let defaultValue: Uploader = Uploader(httpClient: HTTPClient())
}

extension EnvironmentValues {
    var uploader: Uploader {
        get { self[UploaderEnvironmentKey.self] }
        set { self[UploaderEnvironmentKey.self] = newValue }
    }
}
