//
//  UploaderEnvironmentKey.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 10/02/2025.
//

import Foundation
import SwiftUI

private struct UploaderDownloaderEnvironmentKey: EnvironmentKey {
    static let defaultValue: UploaderDownloader = UploaderDownloader(httpClient: HTTPClient())
}

extension EnvironmentValues {
    var uploaderDownloader: UploaderDownloader {
        get { self[UploaderDownloaderEnvironmentKey.self] }
        set { self[UploaderDownloaderEnvironmentKey.self] = newValue }
    }
}
