//
//  HomeView.swift
//  e-commerce app
//
//  Created by Walid Nadim on 4/4/26.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    headerSection
                    
                    HStack {
                        Text("NEW ARRIVALS")
                            .font(.theme.label)
                            .foregroundColor(.theme.textPrimary)
                        
                        Spacer()
                        
                        Button("FILTER") {
                            // TODO
                        }
                        .font(.theme.label)
                        .foregroundColor(.theme.textSecondary)
                        
                        Button("SORT") {
                            // TODO
                        }
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
                .padding()
            }
            .task {
                await viewModel.loadProducts()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: CartView()) {
                        Image(systemName: "cart")
                            .foregroundColor(.theme.secondary)
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
}

#Preview {
    HomeView()
}
