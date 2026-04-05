//
//  CartItemRow.swift
//  e-commerce app
//
//  Created by Walid Nadim on 5/4/26.
//

import SwiftUI

struct CartItemRow: View {
    
    @State private var offsetX: CGFloat = 0
    
    @EnvironmentObject var cartManager: CartManager
    let item: CartItem
    
    var body: some View {
        
        ZStack(alignment: .trailing) {
            
            // 🔴 Delete background (revealed on swipe)
            Button {
                cartManager.remove(product: item.product)
            } label: {
                Image(systemName: "trash")
                    .foregroundColor(.white)
                    .padding()
            }
            .frame(width: 80)
            .background(Color.red)
            .cornerRadius(16)
            
            // 🧱 Main content
            HStack(spacing: 12) {
                
                // Image
                AsyncImage(url: URL(string: item.product.thumbnail)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.2)
                }
                .frame(width: 70, height: 70)
                .cornerRadius(12)
                
                // Info
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text(item.product.title)
                        .font(.theme.bodyText)
                        .foregroundColor(.theme.textPrimary)
                        .lineLimit(2)
                    
                    Text("$\(item.product.price, specifier: "%.2f")")
                        .font(.theme.label)
                        .foregroundColor(.theme.secondary)
                }
                
                Spacer()
                
                // Quantity Controls
                HStack(spacing: 8) {
                    
                    Button {
                        cartManager.updateQuantity(
                            product: item.product,
                            quantity: item.quantity - 1
                        )
                    } label: {
                        Image(systemName: "minus")
                    }
                    
                    Text("\(item.quantity)")
                        .font(.theme.label)
                    
                    Button {
                        cartManager.updateQuantity(
                            product: item.product,
                            quantity: item.quantity + 1
                        )
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                // Delete icon (quick action)
                Button {
                    cartManager.remove(product: item.product)
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.05), radius: 5)
            .offset(x: offsetX) // 👈 IMPORTANT: apply to content only
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if value.translation.width < 0 {
                            offsetX = value.translation.width
                        }
                    }
                    .onEnded { value in
                        if value.translation.width < -80 {
                            offsetX = -80
                        } else {
                            offsetX = 0
                        }
                    }
            )
        }
    }
}
