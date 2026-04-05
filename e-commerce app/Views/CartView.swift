//
//  CartView.swift
//  e-commerce app
//
//  Created by Walid Nadim on 5/4/26.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        VStack {
            
            if cartManager.items.isEmpty {
                Text("Your cart is empty")
                    .font(.theme.bodyText)
                    .foregroundColor(.theme.textSecondary)
            } else {
                List {
                    ForEach(cartManager.items) { item in
                        HStack {
                            Text(item.product.title)
                                .font(.theme.bodyText)
                            
                            Spacer()
                            
                            Text("x\(item.quantity)")
                            
                            Text("$\(item.product.price * Double(item.quantity), specifier: "%.2f")")
                        }
                    }
                }
                
                Text("Total: $\(cartManager.totalPrice, specifier: "%.2f")")
                    .font(.theme.headline)
                    .padding()
            }
        }
        .navigationTitle("Cart")
    }
}

//#Preview {
//    CartView()
//}
