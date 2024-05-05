//
//  ProfileView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/4/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        
        VStack {
            // Profile Header
            HStack {
                CircularProfileImageView(size: .large)
                
                VStack (alignment: .leading){
                    Text("Stefanus Albert Wilson")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Text("Joined since: 05/05/2024")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(.systemGray))
                    
                }
                
                Spacer()
            }
            
            // Wallet / Balance View
            
            HStack {
                VStack (alignment: .leading, spacing: 12){
                    Text("Your Balance")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text("Rp 2.000.000")
                        .foregroundStyle(.white)
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Button {
                        
                    } label: {
                        Text("Top Up")
                            .frame(width: 100, height: 30)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .background(.white)
                            .foregroundStyle(Constant.mainColor)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            
                    }
                    .padding(.top, 10)
                }
                
                Spacer()
                
                Image("logo")
                
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width - 50, height: 170)
            .background(Constant.mainColor)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            
            // Transaction History
            
            
            
            
        }
        .padding(.horizontal, 20)
        
        
        
    }
    
}

#Preview {
    ProfileView()
}
