//
//  PaymentControllerEnvironmentKey.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 07/03/2025.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    @Entry var paymentController = PaymentController(httpClient: HTTPClient())
}


