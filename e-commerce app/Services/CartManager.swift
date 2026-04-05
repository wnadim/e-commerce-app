//
//  CartManager.swift
//  e-commerce app
//
//  Created by Walid Nadim on 5/4/26.
//

import Foundation
import Combine

@MainActor
class CartManager: ObservableObject {
    
    @Published var items: [CartItem] = [] {
        didSet {
            saveCart()
        }
    }
    
    private let cartKey = "cart_items"
    
    init() {
        loadCart()
    }
    
    // Add to cart
    func add(product: Product) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(product: product, quantity: 1))
        }
    }
    
    // Remove item
    func remove(product: Product) {
        items.removeAll { $0.product.id == product.id }
    }
    
    // Update quantity
    func updateQuantity(product: Product, quantity: Int) {
        guard let index = items.firstIndex(where: { $0.product.id == product.id }) else { return }
        
        if quantity <= 0 {
            remove(product: product)
        } else {
            items[index].quantity = quantity
        }
    }
    
    // Total price
    var totalPrice: Double {
        items.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }

    // Total Items
    var totalItems: Int {
        items.reduce(0) { $0 + $1.quantity }
    }
    
    private func saveCart() {
        do {
            let data = try JSONEncoder().encode(items)
            UserDefaults.standard.set(data, forKey: cartKey)
        } catch {
            print("Error saving cart:", error)
        }
    }
    
    private func loadCart() {
        guard let data = UserDefaults.standard.data(forKey: cartKey) else { return }
        
        do {
            let decoded = try JSONDecoder().decode([CartItem].self, from: data)
            self.items = decoded
        } catch {
            print("Error loading cart:", error)
        }
    }
}
