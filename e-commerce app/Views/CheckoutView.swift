//
//  CheckoutView.swift
//  e-commerce app
//
//  Created by Walid Nadim on 5/4/26.
//

import SwiftUI

struct CheckoutView: View {
    
    @State private var selectedPayment = "Apple Pay"
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
                            Text("6th of October City, Cairo, Egypt")
                            Text("+20 10 0464 3477")
                        }
                        .font(.theme.bodyText)
                        .foregroundColor(.theme.textSecondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.05), radius: 5)
                    
                    // MARK: Payment Method
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text("Payment Method")
                            .font(.theme.label)
                            .foregroundColor(.theme.textPrimary)
                        
                        VStack(spacing: 10) {
                            
                            paymentRow(title: "Apple Pay", systemImage: "applelogo")
                            paymentRow(title: "Credit Card", systemImage: "creditcard")
                            paymentRow(title: "Cash on Delivery", systemImage: "banknote")
                            
                        }
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
    
    @ViewBuilder
    private func paymentRow(title: String, systemImage: String) -> some View {
        
        HStack {
            Image(systemName: systemImage)
            
            Text(title)
            
            Spacer()
            
            if selectedPayment == title {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.theme.primary)
            } else {
                Image(systemName: "circle")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(selectedPayment == title ? Color.theme.primary : Color.gray.opacity(0.3), lineWidth: 1)
        )
        .onTapGesture {
            selectedPayment = title
        }
    }
}

#Preview {
    CheckoutView()
        .environmentObject(CartManager())
}

