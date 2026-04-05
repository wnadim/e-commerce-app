//
//  CartItem.swift
//  e-commerce app
//
//  Created by Walid Nadim on 5/4/26.
//

import Foundation

struct CartItem: Identifiable, Codable {
    var id: Int { product.id }
    let product: Product
    var quantity: Int
}
