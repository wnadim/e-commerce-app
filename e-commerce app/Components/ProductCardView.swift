//
//  ProductCardView.swift
//  e-commerce app
//
//  Created by Walid Nadim on 4/4/26.
//

import SwiftUI

struct ProductCardView: View {
    
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            ZStack(alignment: .topTrailing) {
                
                AsyncImage(url: URL(string: product.thumbnail)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.2)
                }
                .frame(height: 180)
                .clipped()
                .cornerRadius(16)
                
                // Wishlist
                Image(systemName: "heart")
                    .foregroundColor(.theme.textSecondary)
                    .padding(8)
                    .background(Color.white)
                    .clipShape(Circle())
                    .padding(8)
            }
            
            Text(product.title)
                .font(.theme.label)
                .foregroundColor(Color.theme.secondary)
                .lineLimit(2)
            
            // Rating
            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .font(.caption)
                
                Text(String(format: "%.1f", product.rating))
                    .font(.caption)
                    .foregroundColor(.theme.textSecondary)
            }
            
            Text("$\(product.price, specifier: "%.2f")")
                .font(.theme.label.weight(.bold))
                .foregroundColor(Color.theme.secondary)
            
            Button {
                // future: quick add to cart
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: "plus")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.theme.primary)
                        .clipShape(Circle())
                        .scaleEffect(0.98)
                }
            }
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 5)
    }
}

#Preview {
    ProductCardView(product: Product(id: 1, title: "Test Product", price: 100, description: "Test", thumbnail: "", images: [], rating: 5))
}
