//
//  CompleteSignUpView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/7/24.
//

import SwiftUI

struct CompleteSignUpView: View {
    
    @EnvironmentObject var viewModel: RegisterViewModel
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 24){
            
            VStack (alignment: .leading, spacing: 8){
                Text("Let's get started")
                    .font(.title3)
                
                Text("Discover the finest deals at unbeatable prices!")
                    .font(.title2)
                    .fontWeight(.semibold)
            }

            
            VStack (alignment: .leading, spacing: 24){
                
                HStack (spacing: 24){
                    Image(systemName: "checkmark.circle.fill")
                        .fontWeight(.bold)
                    
                    Text("Experience Unmatched Quality - Our Guarantee")
                }
                
                HStack (spacing: 24){
                    Image(systemName: "percent")
                        .fontWeight(.bold)
                    
                    Text("Get 20% off for your first purchase")
                }
                
                HStack (spacing: 24){
                    Image(systemName: "shippingbox.fill")
                    
                    Text("Free delivery on order above Rp 200.000,00")
                }
                
                HStack (spacing: 24){
                    Image(systemName: "ticket.fill")
                    
                    Text("Unlock Weekly Discounts with Our Exclusive Vouchers!")
                }
                
            }
            .padding()
            .background(Constant.brownColor)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 8)
            
            Button {
                Task {
                    try await viewModel.createUser()
                }
            } label: {
                Text("Continue to IShowShop")
                      .font(.subheadline)
                      .fontWeight(.semibold)
                      .foregroundStyle(.white)
                      .frame(width: 350, height: 44)
                      .background(Constant.mainColor)
                      .cornerRadius(8)
            }
            .padding(.vertical, 24)
        }
        .padding(.horizontal)

    }
}

#Preview {
    CompleteSignUpView()
}
