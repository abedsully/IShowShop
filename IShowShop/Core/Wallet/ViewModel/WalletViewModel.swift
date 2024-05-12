//
//  WalletViewModel.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/12/24.
//

import Foundation

@MainActor
class WalletViewModel: ObservableObject {
    
    @Published var user: User
    @Published var inputtedNumbers: String = ""
    
    init(user: User) {
        self.user = user
    }
    
    func topUpBalance(value: String, user: User) async throws{
        try await UserService.shared.topUpBalance(value: value, user: user)
    }
}
