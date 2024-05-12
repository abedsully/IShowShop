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
    
    init(user: User) {
        self.user = user
        
        Task {
            try await fetchUserTransactions()
        }
    }
    
    @MainActor
    func fetchUserTransactions() async throws {
        self.transactionLists = try await TransactionService.shared.fetchTransactions()
    }
    
}
