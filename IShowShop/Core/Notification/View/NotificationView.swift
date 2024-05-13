//
//  NotificationView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/10/24.
//

import SwiftUI

struct NotificationView: View {
    @StateObject var viewModel = NotificationViewModel()
    @State private var isLoading: Bool = false
    
    var body: some View {
        NavigationStack {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
                    .frame(width: 50, height: 50)
            } else {
                ScrollView {
                    ForEach(viewModel.orderLists, id: \.self) { transaction in
                        NotificationCell(transaction: transaction)
                    }
                }
                .padding(.top)
                .navigationTitle("Notifications")
            }
        }
        .onAppear{
            isLoading.toggle()
            Task {
                defer { isLoading = false }
                try await viewModel.fetchOrders()
            }
        }
    }
}

#Preview {
    NotificationView()
}
