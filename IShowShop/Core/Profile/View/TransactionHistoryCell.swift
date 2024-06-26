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
    
    private var color: Color {
        return user.isSuper ? .green : .red
    }
    
    private var detail: String {
        return user.isSuper ? "+" : "-"
    }
    
    init(user: User) {
        self.viewModel = ProfileViewModel(user: user)
    }
    
    
    var body: some View {
        ForEach(user.isSuper ? viewModel.allOrders : viewModel.transactionLists, id: \.self) { transaction in
            NavigationLink(value: transaction) {
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
                    .foregroundStyle(Constant.textColor)
                    
                    Spacer()
                    
                    if transaction.transactionCategory == TransactionFilter.order.title {
                        HStack (spacing: 2){
                            Text(detail)
                            PriceFormatter(price: transaction.amount)
                        }
                        .font(.footnote)
                        .foregroundStyle(color)
                        .fontWeight(.semibold)

                    } else {
                        HStack (spacing: 2){
                            Text("+")
                            PriceFormatter(price: transaction.amount)
                        }
                        .font(.footnote)
                        .foregroundStyle(.green)
                        .fontWeight(.semibold)
                    }
                }
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 10)
            }
            .navigationDestination(for: Transaction.self) { transaction in
                TransactionDetailView(transaction: transaction, user: user)
            }
            
            Divider()
                .background(.gray)

        }
    }
}

#Preview {
    TransactionHistoryCell(user: User.MOCK_USER[0])
}
