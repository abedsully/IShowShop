//
//  ProfileViewModel.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/10/24.
//

import Foundation

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var transactionLists = [Transaction]()
    @Published var allOrders = [Transaction]()
    
    init(user: User) {
        self.user = user
        
        Task {
            try await fetchUserTransactions()
        }
        
        Task {
            try await fetchAllOrders()
        }
    }
    
    @MainActor
    func fetchUserTransactions() async throws {
        self.transactionLists = try await TransactionService.shared.fetchTransactions()
    }
    
    @MainActor
    func fetchAllOrders() async throws {
        self.allOrders = try await TransactionService.shared.fetchAllOrders()
    }
    
}
