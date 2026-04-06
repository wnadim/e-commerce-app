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
                
                VStack(spacing: 16) {
                    
                    Image(systemName: "cart")
                        .font(.system(size: 50))
                        .foregroundColor(.theme.textSecondary)
                    
                    Text("Your cart is empty")
                        .font(.theme.bodyText)
                        .foregroundColor(.theme.textPrimary)
                    
                    Text("Browse products and add them to your cart")
                        .font(.theme.label)
                        .foregroundColor(.theme.textSecondary)
                    
                    NavigationLink(destination: HomeView()) {
                        Text("Start Shopping")
                    }
                    .buttonStyle(PrimaryButtonStyle())
            }
                
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
                        
                        NavigationLink(destination: CheckoutView()) {
                            HStack {
                                Spacer()
                                Text("Proceed to Checkout")
                                Spacer()
                            }
                        }
                        .buttonStyle(PrimaryButtonStyle())
                        
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
