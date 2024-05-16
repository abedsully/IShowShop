//
//  FavoriteProductViewModel.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/16/24.
//

import Foundation

class FavoriteProductViewModel: ObservableObject {
    
    @Published var favoriteProducts = [Product]()
    
    init() {
        Task {
            try await fetchFavoriteProducts()
        }
    }
    
    @MainActor
    func fetchFavoriteProducts() async throws {
        self.favoriteProducts = try await UserService.shared.fetchUserFavoriteProduct()
    }
}
