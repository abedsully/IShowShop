//
//  ProductViewModel.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/12/24.
//

import Foundation
import SwiftUI

@MainActor
class ProductViewModel: ObservableObject {
    @Published var product: Product
    
    init(product: Product) {
        self.product = product
        
        Task {
            try await checkIfUserLikedProduct()
        }
    }
    
    @MainActor
    func addToCart() async throws {
        try await UserService.shared.addToCart(product)
    }
    
    @MainActor
    func removeFromCart() async throws {
        try await UserService.shared.removeFromCart(product)
    }
    
    @MainActor
    func addToFavorite() async throws {
        let productCopy = product
        product.isFavorite = true
        try await UserService.shared.likeProduct(productCopy)
    }
    
    @MainActor
    func removeFromFavorite() async throws {
        let productCopy = product
        product.isFavorite = false
        try await UserService.shared.unlikeProduct(productCopy)
    }
    
    func checkIfUserLikedProduct() async throws {
        self.product.isFavorite = try await UserService.shared.checkIfProductIsFavoriteByUser(product)
    }
    
    
}

