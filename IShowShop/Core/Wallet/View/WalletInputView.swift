//
//  WalletInputView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/12/24.
//

import SwiftUI

struct WalletInputView: View {
    
    let user: User
    @Environment (\.dismiss) var dismiss 
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 48){
                VStack(spacing: 24) {
                    Text("Top Up Wallet")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    
                    Text("Please enter the amount of money to top up")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                }
                .padding(.top)

                
                NumberPadView(user: user)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .imageScale(.large)
                            .foregroundStyle(.black)
                    }
                }
            }
        }
        .padding(.vertical)
        
    }
}

#Preview {
    WalletInputView(user: User.MOCK_USER[0])
}
