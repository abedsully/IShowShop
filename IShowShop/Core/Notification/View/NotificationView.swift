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
    
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        NavigationStack {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
                    .frame(width: 50, height: 50)
            } else {
                ScrollView {
                    if user.isSuper {
                        ForEach(viewModel.allOrders, id: \.self) { transaction in
                            NavigationLink(value: transaction) {
                                NotificationCell(transaction: transaction, user: user)
                                    .foregroundStyle(.black)
                                    .multilineTextAlignment(.leading)
                            }
                            .navigationDestination(for: Transaction.self) { transaction in
                                TransactionDetailView(transaction: transaction, user: user)
                            }
                        }
                    } else {
                        ForEach(viewModel.orderLists, id: \.self) { transaction in
                            NavigationLink(value: transaction) {
                                NotificationCell(transaction: transaction, user: user)
                                    .foregroundStyle(.black)
                                    .multilineTextAlignment(.leading)
                            }
                            .navigationDestination(for: Transaction.self) { transaction in
                                TransactionDetailView(transaction: transaction, user: user)
                            }
                        }
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
                
                user.isSuper ? try await viewModel.fetchAllOrders() : try await viewModel.fetchOrders()
            }
        }
        .refreshable {
            Task {
                user.isSuper ? try await viewModel.fetchAllOrders() : try await viewModel.fetchOrders()
            }
        }
    }
}

#Preview {
    NotificationView(user: User.MOCK_USER[0])
}
