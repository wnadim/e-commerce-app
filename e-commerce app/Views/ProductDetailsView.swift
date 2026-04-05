//
//  ProductDetailsView.swift
//  e-commerce app
//
//  Created by Walid Nadim on 5/4/26.
//

import SwiftUI

struct ProductDetailsView: View {
    
    @State private var showAddedMessage = false
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var cartManager: CartManager
    
    let product: Product
    
    @State private var selectedImageIndex = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            
            // MARK: Image Carousel (FULL SCREEN TOP)
            TabView(selection: $selectedImageIndex) {
                ForEach(product.images.indices, id: \.self) { index in
                    AsyncImage(url: URL(string: product.images[index])) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .overlay(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.black.opacity(0.35),
                                        Color.black.opacity(0.1),
                                        Color.clear
                                    ]),
                                    startPoint: .top,
                                    endPoint: .center
                                )
                            )
                    } placeholder: {
                        Color.gray.opacity(0.2)
                    }
                    .frame(height: 350)
                    .clipped()
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 350)
            .ignoresSafeArea(edges: .top)
            
            // MARK: Content
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Push content below image
                    Spacer()
                        .frame(height: 320)
                    
                    // MARK: Dots Indicator
                    if product.images.count > 1 {
                        HStack(spacing: 6) {
                            ForEach(product.images.indices, id: \.self) { index in
                                Circle()
                                    .fill(index == selectedImageIndex ? Color.theme.primary : Color.gray.opacity(0.3))
                                    .frame(width: 6, height: 6)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                    // MARK: Product Info
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text(product.title)
                            .font(.theme.headline)
                            .foregroundColor(.theme.textPrimary)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .font(.caption)
                            
                            Text(String(format: "%.1f", product.rating))
                                .font(.theme.label)
                                .foregroundColor(.theme.textSecondary)
                        }
                        
                        Text("$\(product.price, specifier: "%.2f")")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.theme.secondary)
                        
                        Text(product.description)
                            .font(.theme.bodyText)
                            .foregroundColor(.theme.textSecondary)
                            .padding(.top, 8)
                    }
                    .padding(.horizontal)
                    
                    // MARK: Button
                    Button {
                        cartManager.add(product: product)
                        
                        withAnimation {
                            showAddedMessage = true
                        }
                            
                            // Auto dismiss after short delay
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                dismiss()
                            }
                        
                    } label: {
                        HStack {
                            Spacer()
                            Text("Add to Cart")
                            Spacer()
                        }
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .padding(.horizontal)
                    .padding(.top)
                }
            }
            if showAddedMessage {
                VStack {
                    Spacer()
                    
                    Text("Added to cart 🛒")
                        .font(.theme.label)
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.bottom, 40)
                        .transition(.move(edge: .bottom))
                }
            }
        }
    }
}

#Preview {
    ProductDetailsView(
        product: Product(
            id: 1,
            title: "Structured Wool Coat",
            price: 249.00,
            description: "A sharply tailored coat with clean lines and a soft wool finish.",
            thumbnail: "https://example.com/coat-thumbnail.jpg",
            images: [
                "https://example.com/coat-1.jpg",
                "https://example.com/coat-2.jpg"
            ],
            rating: 4.8
        )
    )
}
