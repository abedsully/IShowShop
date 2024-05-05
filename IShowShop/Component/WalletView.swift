//
//  WalletView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/5/24.
//

import SwiftUI

struct WalletView: View {
    var body: some View {
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
        .frame(height: 170)
        .background(Constant.mainColor)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .padding(.vertical)

    }
}

#Preview {
    WalletView()
}
