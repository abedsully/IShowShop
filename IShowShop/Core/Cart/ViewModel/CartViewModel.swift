//
//  CartViewModel.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/12/24.
//

import Foundation

class CartViewModel: ObservableObject {
    
    @Published var productInCartList = [Product]()
    @Published var user: User
    
    init(user: User) {
        self.user = user
        Task {
            try await fetchProductsInCart()
        }
    }
    
    @MainActor
    func fetchProductsInCart() async throws{
        self.productInCartList = try await ProductService.fetchCartList()
    }
}
