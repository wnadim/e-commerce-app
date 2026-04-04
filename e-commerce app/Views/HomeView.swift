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

private var headerSection: some View {
    VStack(alignment: .leading, spacing: 12) {
        
        Text("THE CURATED MONOLITH")
            .font(.title2)
            .fontWeight(.bold)
        
        Text("Structural precision meets archival rarity.")
            .font(.subheadline)
            .foregroundColor(.gray)
        
        Button {
            
        } label: {
            HStack {
                Text("Explore Collection")
                Image(systemName: "arrow.right")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)
        }
    }
}

#Preview {
    HomeView()
}
