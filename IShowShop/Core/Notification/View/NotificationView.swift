//
//  NotificationView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/10/24.
//

import SwiftUI

struct NotificationView: View {
    @StateObject var viewModel = NotificationViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(viewModel.orderLists, id: \.self) { transaction in
                    NotificationCell(transaction: transaction)
                }
            }
            .padding(.top)
            .navigationTitle("Notifications")
        }
        .onAppear{
            Task {
                try await viewModel.fetchOrders()
            }
        }
    }
}

#Preview {
    NotificationView()
}
