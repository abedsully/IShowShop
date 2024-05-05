//
//  TransactionHistoryCell.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/5/24.
//

import SwiftUI

struct TransactionHistoryCell: View {
    var body: some View {
        HStack {
            Image("logo")
                .resizable()
                .frame(width: 80, height: 80)
                .scaledToFill()
        
            
            VStack (alignment: .leading){
                Text("Adidas Shirt")
                    .font(.title3)
                    .fontWeight(.semibold)
                Text("Great shirt for playing football")
                    .font(.caption)
            }
            
            Spacer()
            
            Text("- 100.000")
                .font(.footnote)
                .foregroundStyle(.red)
                .fontWeight(.semibold)
        }
        .padding(.horizontal, 10)
        
        Divider()
        
    }
}

#Preview {
    TransactionHistoryCell()
}
