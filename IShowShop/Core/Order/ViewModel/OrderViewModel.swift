//
//  OrderViewModel.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/13/24.
//

import Foundation

class OrderViewModel: ObservableObject {
    
    @Published var addressList = [Address]()
    @Published var product: Product
    @Published var user: User
    
    
    init(product: Product, user: User) {
        self.product = product
        self.user = user
        
        Task {
            try await fetchAddressList()
        }
    }
    
    @MainActor
    func addDeliveryAddress(address: String) async throws{
        try await UserService.shared.addDeliveryAddress(address: address)
    }
    
    @MainActor
    func fetchAddressList() async throws {
        self.addressList = try await TransactionService.shared.fetchUserAddress()
    }
    
    
    @MainActor
    func checkOutOrder(category: String, amount: Double, address: String, deliveryFee: Double, discount: Double, quantity: Double) async throws {
        try await TransactionService.shared.checkoutOrder(user: user, product: product, category: category, amount: amount, deliveryAddress: address, deliveryFee: deliveryFee, discount: discount, quantity: quantity)
    }
    
}
