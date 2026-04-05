//
//  AppState.swift
//  e-commerce app
//
//  Created by Walid Nadim on 6/4/26.
//

import SwiftUI
import Combine

class AppState: ObservableObject {
    @Published var rootResetToken = UUID()

    func resetToHome() {
        rootResetToken = UUID()
    }
}
