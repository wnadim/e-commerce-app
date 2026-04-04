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
                .frame(height: 160)
                .clipped()
                .cornerRadius(16)
                
                // Wishlist
                Image(systemName: "heart")
                    .padding(8)
                    .background(Color.white)
                    .clipShape(Circle())
                    .padding(8)
            }
            
            Text(product.title)
                .font(.headline)
                .lineLimit(1)
            
            // Rating
            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .font(.caption)
                
                Text(String(format: "%.1f", product.rating))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Text("$\(product.price, specifier: "%.2f")")
                .font(.subheadline)
                .fontWeight(.semibold)
            
            // Add Button
            HStack {
                Spacer()
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.pink)
                    .clipShape(Circle())
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
    }
}
