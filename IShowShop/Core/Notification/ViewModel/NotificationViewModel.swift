//
//  NotificationViewModel.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/13/24.
//

import Foundation

class NotificationViewModel: ObservableObject {
    @Published var orderLists = [Transaction]()
    @Published var allOrders = [Transaction]()
    
    init() {
        Task {
            try await fetchAllOrders()
        }
        
        Task {
            try await fetchOrders()
        }
    }
    
    @MainActor
    func fetchOrders() async throws {
        self.orderLists = try await TransactionService.shared.fetchOrders()
    }
    
    @MainActor
    func fetchAllOrders() async throws {
        self.allOrders = try await TransactionService.shared.fetchAllOrders()
    }
    
    @MainActor
    func completeOrder(buyerId: String, transactionId: String) async throws {
        try await TransactionService.shared.completeOrder(buyerId: buyerId, transactionId: transactionId)
    }
}
