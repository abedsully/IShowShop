//
//  NotificationCell.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/10/24.
//

import SwiftUI
import Kingfisher

struct NotificationCell: View {
    let transaction: Transaction
    
    var body: some View {
        HStack {
            KFImage(URL(string: transaction.product?.productImageURL ?? ""))
                .resizable()
                .frame(width: 80, height: 80)
                .scaledToFill()
            
            Text("Order ") + Text("\(transaction.id)").fontWeight(.semibold) +  Text(" has been received, please wait for the seller to approve your order")

        }
        .padding(.horizontal, 10)
        .font(.subheadline)
        
        Divider()
        
    }
}

#Preview {
    NotificationCell(transaction: Transaction.MOCK_TRANSACTION[0])
}
