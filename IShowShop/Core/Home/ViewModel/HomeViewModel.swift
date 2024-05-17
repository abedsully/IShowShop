//
//  HomeViewModel.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/12/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var products = [Product]()
    @Published var mostPurchasedProducts = [Product]()
    @Published var mostFavoriteProducts = [Product]()
    
    init() {
        Task {
            try await fetchPosts()
        }
        
        Task {
            try await fetchMostBoughtProducts()
        }
        
        Task {
            try await fetchMostFavoriteProducts()
        }
    }
    
    @MainActor
    func fetchPosts() async throws {
        self.products = try await ProductService.fetchAllProducts()
    }
    
    @MainActor
    func fetchMostBoughtProducts() async throws {
        self.mostPurchasedProducts = try await ProductService.fetchMostPurchasedProducts()
    }
    
    @MainActor
    func fetchMostFavoriteProducts() async throws {
        self.mostFavoriteProducts = try await ProductService.fetchMostFavoriteProducts()
    }
}
