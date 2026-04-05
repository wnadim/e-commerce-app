//
//  CheckoutView.swift
//  e-commerce app
//
//  Created by Walid Nadim on 5/4/26.
//

import SwiftUI

struct CheckoutView: View {
    
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        VStack(spacing: 16) {
            
            ScrollView {
                VStack(spacing: 16) {
                    
                    // MARK: Items
                    ForEach(cartManager.items) { item in
                        HStack {
                            Text(item.product.title)
                                .font(.theme.bodyText)
                                .lineLimit(1)
                            
                            Spacer()
                            
                            Text("x\(item.quantity)")
                            
                            Text("$\(item.product.price * Double(item.quantity), specifier: "%.2f")")
                        }
                        .font(.theme.label)
                    }
                    
                    // MARK: Shipping Address
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Shipping Address")
                            .font(.theme.label)
                            .foregroundColor(.theme.textPrimary)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Walid Nadim")
                            Text("Cairo, Egypt")
                            Text("+20 12 8144 5288")
                        }
                        .font(.theme.bodyText)
                        .foregroundColor(.theme.textSecondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.05), radius: 5)
                    
                }
                .padding()
            }
            
            Divider()
            
            // MARK: Total
            HStack {
                Text("Total")
                    .font(.theme.label)
                
                Spacer()
                
                Text("$\(cartManager.totalPrice, specifier: "%.2f")")
                    .font(.theme.headline)
                    .foregroundColor(.theme.secondary)
            }
            .padding(.horizontal)
            
            // MARK: Button
            Button {
                
            } label: {
                HStack {
                    Spacer()
                    Text("Place Order")
                    Spacer()
                }
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding()
        }
        .navigationTitle("Checkout")
        .background(Color.theme.background)
    }
}

