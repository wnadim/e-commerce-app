//
//  ProductService.swift
//  e-commerce app
//
//  Created by Walid Nadim on 4/4/26.
//

import Foundation

class ProductService {
    
    static let shared = ProductService()
    
    func fetchProducts() async throws -> [Product] {
        guard let url = URL(string: "https://dummyjson.com/products") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(ProductResponse.self, from: data)
        
        return decoded.products
    }
}
