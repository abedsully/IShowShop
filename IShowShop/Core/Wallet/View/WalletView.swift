//
//  WalletView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/5/24.
//

import SwiftUI

struct WalletView: View {
    
    @State private var showWalletTopUp = false
    
    @ObservedObject var viewModel: WalletViewModel
    
    private var user: User {
        return viewModel.user
    }
    
    init(user: User) {
        self.viewModel = WalletViewModel(user: user)
    }
    
    var body: some View {
        HStack {
            VStack (alignment: .leading, spacing: 12){
                Text("Your Balance")
                    .foregroundStyle(.white)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                PriceFormatter(price: user.balance)
                    .foregroundStyle(.white)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Button {
                    showWalletTopUp.toggle()
                } label: {
                    Text("Top Up")
                        .frame(width: 100, height: 30)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .background(.white)
                        .foregroundStyle(Constant.mainColor)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
                .fullScreenCover(isPresented: $showWalletTopUp) {
                    WalletInputView(user: user)
                }
                .padding(.top, 10)
            }
            
            Spacer()
            
            Image("logo")
            
        }
        .padding()
        .frame(height: 170)
        .background(Constant.mainColor)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .padding(.vertical)

    }
}

#Preview {
    WalletView(user: User.MOCK_USER[0])
}
