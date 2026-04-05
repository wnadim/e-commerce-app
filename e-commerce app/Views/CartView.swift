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
                
                Spacer()
                
                Text("Your cart is empty")
                    .font(.theme.bodyText)
                    .foregroundColor(.theme.textSecondary)
                
                Spacer()
                
            } else {
                
                ScrollView {
                    VStack(spacing: 16) {
                        
                        ForEach(cartManager.items) { item in
                            CartItemRow(item: item)
                        }
                        
                        // Total
                        HStack {
                            Text("Total")
                                .font(.theme.label)
                            
                            Spacer()
                            
                            Text("$\(cartManager.totalPrice, specifier: "%.2f")")
                                .font(.theme.headline)
                                .foregroundColor(.theme.secondary)
                        }
                        .padding()
                    }
                    .padding()
                }
            }
        }
        .background(Color.theme.background)
        .navigationTitle("Cart")
    }
}

#Preview {
    CartView()
        .environmentObject(CartManager())
}
