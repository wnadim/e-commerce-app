//
//  e_commerce_appApp.swift
//  e-commerce app
//
//  Created by Walid Nadim on 4/4/26.
//

import SwiftUI

@main
struct e_commerce_appApp: App {
    
    @StateObject var cartManager = CartManager()
    @StateObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .id(appState.rootResetToken)
                .environmentObject(cartManager)
                .environmentObject(appState)
        }
    }
}
