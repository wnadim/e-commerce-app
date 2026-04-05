//
//  OrderConfirmationView.swift
//  e-commerce app
//
//  Created by Walid Nadim on 6/4/26.
//

import SwiftUI

struct OrderConfirmationView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 24) {
            
            Spacer()
            
            // Success Icon
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.green)
            
            // Title
            Text("Order Confirmed 🎉")
                .font(.theme.headline)
                .foregroundColor(.theme.textPrimary)
            
            // Subtitle
            Text("Your order has been placed successfully.")
                .font(.theme.bodyText)
                .foregroundColor(.theme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
            
            // Back to Home
            Button {
                dismiss()
            } label: {
                HStack {
                    Spacer()
                    Text("Back to Home")
                    Spacer()
                }
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .background(Color.theme.background)
    }
}
#Preview {
    OrderConfirmationView()
}
