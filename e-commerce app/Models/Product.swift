//
//  Product.swift
//  e-commerce app
//
//  Created by Walid Nadim on 4/4/26.
//

import Foundation

struct ProductResponse: Codable {
    let products: [Product]
}

struct Product: Identifiable, Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let thumbnail: String
    let images: [String]
    let rating: Double
}
