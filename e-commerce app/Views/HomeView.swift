//
//  HomeView.swift
//  e-commerce app
//
//  Created by Walid Nadim on 4/4/26.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    @State private var isLoading = false
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var appState: AppState
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 16) {
                        
                        if isLoading {
                            
                            // 🟣 FULL SCREEN SKELETON
                            
                            VStack(spacing: 16) {
                                
                                // Header skeleton
                                Rectangle()
                                    .fill(Color.gray.opacity(0.15))
                                    .frame(height: 30)
                                    .cornerRadius(8)
                                
                                Rectangle()
                                    .fill(Color.gray.opacity(0.15))
                                    .frame(width: 200, height: 16)
                                    .cornerRadius(6)
                                
                                Rectangle()
                                    .fill(Color.gray.opacity(0.15))
                                    .frame(width: 180, height: 40)
                                    .cornerRadius(12)
                                
                                // Grid skeleton
                                LazyVGrid(columns: columns, spacing: 16) {
                                    ForEach(0..<6, id: \.self) { _ in
                                        ProductCardSkeleton()
                                    }
                                }
                            }
                            
                        } else {
                            
                            // 🟢 REAL CONTENT
                            
                            headerSection
                            
                            HStack {
                                Text("NEW ARRIVALS")
                                    .font(.theme.label)
                                    .foregroundColor(.theme.textPrimary)
                                
                                Spacer()
                                
                                Button("FILTER") {}
                                    .font(.theme.label)
                                    .foregroundColor(.theme.textSecondary)
                                
                                Button("SORT") {}
                                    .font(.theme.label)
                                    .foregroundColor(.theme.textSecondary)
                            }
                            .padding(.horizontal)
                            
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(viewModel.products) { product in
                                    NavigationLink(destination: ProductDetailsView(product: product)) {
                                        ProductCardView(product: product)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            
            .task {
                isLoading = true
                await viewModel.loadProducts()
                isLoading = false
            }
            .toolbar {
                NavigationLink(destination: CartView()) {
                    ZStack(alignment: .topTrailing) {
                        
                        Image(systemName: "cart")
                            .foregroundColor(.theme.secondary)
                        
                        if cartManager.totalItems > 0 {
                            Text("\(cartManager.totalItems)")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(.white)
                                .padding(6)
                                .background(Color.theme.primary)
                                .clipShape(Circle())
                                .offset(x: 8, y: -8)
                                .scaleEffect(cartManager.totalItems > 0 ? 1 : 0.5)
                                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: cartManager.totalItems)
                                .transition(.scale)
                        }
                    }
                }
            }
        }
    }
}

extension HomeView {
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text("THE CURATED MONOLITH")
                .font(.theme.headline)
                .foregroundColor(Color.theme.textPrimary)
            
            Text("Structural precision meets archival rarity.")
                .font(.theme.bodyText)
                .foregroundColor(.theme.textSecondary)
            
            Button {
                
            } label: {
                HStack {
                    Text("Explore Collection")
                    Image(systemName: "arrow.right")
                }
                .font(.theme.label)
                .padding()
                .background(Color.theme.secondary)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
        }
    }
    
    struct ProductCardSkeleton: View {
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                
                Rectangle()
                    .fill(Color.gray.opacity(0.15))
                    .frame(height: 150)
                    .cornerRadius(12)
                
                Rectangle()
                    .fill(Color.gray.opacity(0.15))
                    .frame(height: 12)
                    .cornerRadius(6)
                
                Rectangle()
                    .fill(Color.gray.opacity(0.15))
                    .frame(width: 60, height: 12)
                    .cornerRadius(6)
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(CartManager())
        .environmentObject(AppState())
}
