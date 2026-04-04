//
//  HomeViewModel.swift
//  e-commerce app
//
//  Created by Walid Nadim on 4/4/26.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var isLoading = false
    
    func loadProducts() async {
        isLoading = true
        do {
            products = try await ProductService.shared.fetchProducts()
        } catch {
            print("Error fetching products:", error)
        }
        isLoading = false
    }
}
