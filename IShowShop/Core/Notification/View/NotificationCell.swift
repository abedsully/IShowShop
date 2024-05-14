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
    let user: User
    
    var body: some View {
        VStack (spacing: 1){
            HStack (spacing: 8){
                KFImage(URL(string: transaction.product?.productImageURL ?? ""))
                    .resizable()
                    .frame(maxWidth: 80, maxHeight: 80)
                    .scaledToFill()
                
                if transaction.status == false {
                    Text("Order ") + Text("\(transaction.id)").fontWeight(.semibold) +  Text(user.isSuper ?  " has been received at \(transaction.timestamp.timestampString()), please proceed the delivery": " has been received at \(transaction.timestamp.timestampString()), please wait for the seller to deliver the product")
                } else {
                    Text("Order ") + Text("\(transaction.id)").fontWeight(.semibold) +  Text(user.isSuper ? " has been delivered successfully at \(transaction.deliveryCompleteDate?.timestampString() ?? "")" :" has been delivered at \(transaction.deliveryCompleteDate?.timestampString() ?? ""), hope you're enjoying it")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(transaction.status == true ? .green.opacity(0.2) : .clear)
    }
}

#Preview {
    NotificationCell(transaction: Transaction.MOCK_TRANSACTION[0], user: User.MOCK_USER[0])
}
