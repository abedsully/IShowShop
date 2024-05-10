//
//  ProfileView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/4/24.
//

import SwiftUI

struct ProfileView: View {
    
    let user: User
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack (alignment: .leading, spacing: 10){
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
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "pencil")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                        }
                        
                    }
                    .padding(.top)
                    
                    // Wallet / Balance View
                    WalletView()
                    
                    // Transaction History
                    Text("Transaction History")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    ForEach(0 ... 5, id: \.self) { index in
                        TransactionHistoryCell()
                    }
                }
            }
            .navigationTitle(user.username)
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                }
            }
        }
        
        
        
    }
    
}

#Preview {
    ProfileView(user: User.MOCK_USER[0])
}
