//
//  NotificationCell.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/10/24.
//

import SwiftUI

struct NotificationCell: View {
    var body: some View {
        HStack {
            Image("logo")
                .resizable()
                .frame(width: 80, height: 80)
                .scaledToFill()
            
            Text("Order ") + Text("1213421412").fontWeight(.semibold) +  Text(" has been received, please wait for the seller to approve your order")

        }
        .padding(.horizontal, 10)
        .font(.subheadline)
        
        Divider()
        
    }
}

#Preview {
    NotificationCell()
}
