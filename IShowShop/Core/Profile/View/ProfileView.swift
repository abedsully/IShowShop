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
                    ProfileHeaderView(user: user)
                    
                    // Wallet / Balance View
                    WalletView(user: user)
                    
                    // Transaction History
                    VStack {
                        user.isSuper ? Text("Sales Summary") : Text("Transaction History")
                    }
                    .font(.title2)
                    .fontWeight(.semibold)

                    TransactionHistoryCell(user: user)
                        .padding(.top)
                }
            }
            .navigationTitle(user.fullName != nil ? user.username : "Profile")
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
        .onAppear {
            Task {
                try await AuthService.shared.loadUserData()
            }
        }
        
        
        
    }
    
}

#Preview {
    ProfileView(user: User.MOCK_USER[0])
}
