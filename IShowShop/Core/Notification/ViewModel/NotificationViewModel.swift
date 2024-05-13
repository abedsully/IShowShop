//
//  NotificationViewModel.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/13/24.
//

import Foundation

class NotificationViewModel: ObservableObject {
    @Published var orderLists = [Transaction]()
    
    init() {
        Task {
            try await fetchOrders()
        }
    }
    
    @MainActor
    func fetchOrders() async throws {
        self.orderLists = try await TransactionService.shared.fetchOrders()
    }
}
