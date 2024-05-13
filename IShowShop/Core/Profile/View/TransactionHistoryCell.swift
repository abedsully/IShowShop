//
//  TransactionHistoryCell.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/5/24.
//

import SwiftUI
import Kingfisher

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
                if transaction.transactionCategory == TransactionFilter.order.title {
                    KFImage(URL(string: transaction.product?.productImageURL ?? ""))
                        .resizable()
                        .frame(width: 80, height: 80)
                        .scaledToFill()
                }
                
                else {
                    Image("logo")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .scaledToFill()
                }
                
                VStack (alignment: .leading){
                    if transaction.transactionCategory == TransactionFilter.order.title {
                        Text(transaction.product?.name ?? "")
                            .font(.title3)
                            .fontWeight(.semibold)
                    } else {
                        Text(transaction.transactionCategory)
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    Text(transaction.timestamp.timestampString())
                        .font(.caption)
                }
                
                Spacer()
                
                if transaction.transactionCategory == TransactionFilter.topUp.title {
                    
                    HStack (spacing: 2){
                        Text("+")
                        PriceFormatter(price: transaction.amount)
                    }
                    .font(.footnote)
                    .foregroundStyle(.green)
                    .fontWeight(.semibold)

                } else {
                    HStack (spacing: 2){
                        Text("-")
                        PriceFormatter(price: transaction.amount)
                    }
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
