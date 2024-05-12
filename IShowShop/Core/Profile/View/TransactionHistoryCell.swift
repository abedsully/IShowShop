//
//  TransactionHistoryCell.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/5/24.
//

import SwiftUI

struct TransactionHistoryCell: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    private var user: User {
        return viewModel.user
    }
    
    init(user: User) {
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        ForEach(viewModel.transactionLists, id: \.self) { transaction in
            HStack {
                Image("logo")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .scaledToFill()
            
                
                VStack (alignment: .leading){
                    Text(transaction.transactionCategory)
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text(transaction.timestamp.timestampString())
                        .font(.caption)
                }
                
                Spacer()
                
                if transaction.transactionCategory == TransactionFilter.topUp.title {
                   PriceFormatter(price: transaction.amount)
                        .font(.footnote)
                        .foregroundStyle(.green)
                        .fontWeight(.semibold)
                } else {
                    Text("\(transaction.amount)")
                         .font(.footnote)
                         .foregroundStyle(.red)
                         .fontWeight(.semibold)
                }


            }
            .padding(.horizontal, 10)
            
            Divider()
        }

        
    }
}

#Preview {
    TransactionHistoryCell(user: User.MOCK_USER[0])
}
