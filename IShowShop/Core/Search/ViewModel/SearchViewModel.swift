//
//  SearchViewModel.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/11/24.
//

import Foundation

class SearchViewModel: ObservableObject {
    
    @Published var clothes = [Product]()
    @Published var shoes = [Product]()
    @Published var electronics = [Product]()
    @Published var essentials = [Product]()
    @Published var others = [Product]()
    
    init() {
        Task {
            try await fetchClothesProduct()
        }
        
        Task {
            try await fetchShoesProducts()
        }
        
        Task {
            try await fetchElectronicsProduct()
        }
        
        Task {
            try await fetchEssentialsProducts()
        }
        
        Task {
            try await fetchOthersProduct()
        }
    }
    
    @MainActor
    func fetchClothesProduct() async throws{
        self.clothes = try await ProductService.fetchClothesProducts()
    }
    
    @MainActor
    func fetchShoesProducts() async throws{
        self.shoes = try await ProductService.fetchShoesProducts()
    }
    
    @MainActor
    func fetchElectronicsProduct() async throws{
        self.electronics = try await ProductService.fetchElectronicProducts()
    }
    
    @MainActor
    func fetchEssentialsProducts() async throws{
        self.essentials = try await ProductService.fetchEssentialsProducts()
    }
    
    @MainActor
    func fetchOthersProduct() async throws{
        self.others = try await ProductService.fetchOtherProducts()
    }
    
}
