//
//  ProductViewModel.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/12/24.
//

import Foundation
import SwiftUI

class ProductViewModel: ObservableObject {
    @Published var product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    @MainActor
    func addToCart() async throws {
        try await UserService.shared.addToCart(product)
    }
    
    @MainActor
    func removeFromCart() async throws {
        try await UserService.shared.removeFromCart(product)
    }
    
}

