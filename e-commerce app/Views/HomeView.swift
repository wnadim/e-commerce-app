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
        NavigationView {
            ScrollView {
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    headerSection
                    
                    HStack {
                        Text("NEW ARRIVALS")
                            .font(.theme.label)
                            .foregroundColor(.theme.secondary)
                        
                        Spacer()
                        
                        Button("FILTER") {
                            // TODO
                        }
                        .font(.theme.label)
                        .foregroundColor(.gray)
                        
                        Button("SORT") {
                            // TODO
                        }
                        .font(.theme.label)
                        .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.products) { product in
                            ProductCardView(product: product)
                        }
                    }
                }
                .padding()
            }
            .navigationBarHidden(true)
            .task {
                await viewModel.loadProducts()
            }
        }
    }
}

extension HomeView {
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text("THE CURATED MONOLITH")
                .font(.theme.headline)
                .foregroundColor(Color.theme.secondary)
            
            Text("Structural precision meets archival rarity.")
                .font(.theme.bodyText)
                .foregroundColor(.theme.neutral)
            
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
