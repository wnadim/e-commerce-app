//
//  CartItemRow.swift
//  e-commerce app
//
//  Created by Walid Nadim on 5/4/26.
//

import SwiftUI

struct CartItemRow: View {
    
    @State private var offsetX: CGFloat = 0
    @State private var isUpdating = false
    
    @EnvironmentObject var cartManager: CartManager
    let item: CartItem
    
    var body: some View {
        
        ZStack(alignment: .trailing) {
            
            // 🔴 Delete background (revealed on swipe)
            Button {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
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
                        guard !isUpdating else { return }
                            isUpdating = true
                        
                        withAnimation {
                            cartManager.updateQuantity(
                                product: item.product,
                                quantity: item.quantity - 1
                            )
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            isUpdating = false
                        }
                    } label: {
                        Image(systemName: "minus")
                    }
                    .disabled(isUpdating)
                    .opacity(isUpdating ? 0.5 : 1)
                    
                    Text("\(item.quantity)")
                        .font(.theme.label)
                    
                    Button {
                        guard !isUpdating else { return }
                            isUpdating = true
                        
                        withAnimation {
                            cartManager.updateQuantity(
                                product: item.product,
                                quantity: item.quantity + 1
                            )
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                isUpdating = false
                            }
                    } label: {
                        Image(systemName: "plus")
                    }
                    .disabled(isUpdating)
                    .opacity(isUpdating ? 0.5 : 1)
                }
                
                // Delete icon (quick action)
                Button {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
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
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            if value.translation.width < -80 {
                                offsetX = -80
                            } else {
                                offsetX = 0
                            }
                        }
                    }
            )
        }
    }
}

#Preview {
    CartItemRow(item: CartItem(product: Product(id: 1, title: "Test Product", price: 100, description: "Test", thumbnail: "", images: [], rating: 5), quantity: 1))
        .environmentObject(CartManager())
}
