//
//  ProductService.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/11/24.
//

import Foundation
import Firebase

struct ProductService {
    
    
    static func fetchClothesProducts() async throws -> [Product] {
        let snapshot = try await Constant.productCollection.document(CategoryFilter.clothes.title).collection("product-list").getDocuments()
        var clothes = try snapshot.documents.compactMap( {try $0.data(as: Product.self)} )
        
        return clothes
    }
    
    static func fetchShoesProducts() async throws -> [Product] {
        let snapshot = try await Constant.productCollection.document(CategoryFilter.shoes.title).collection("product-list").getDocuments()
        var shoes = try snapshot.documents.compactMap( {try $0.data(as: Product.self )} )
        
        return shoes
    }
    
    static func fetchElectronicProducts() async throws -> [Product] {
        let snapshot = try await Constant.productCollection.document(CategoryFilter.electronics.title).collection("product-list").getDocuments()
        var electronics = try snapshot.documents.compactMap( {try $0.data(as: Product.self)} )
        
        return electronics
    }
    
    static func fetchEssentialsProducts() async throws -> [Product] {
        let snapshot = try await Constant.productCollection.document(CategoryFilter.essentials.title).collection("product-list").getDocuments()
        var essentials = try snapshot.documents.compactMap( {try $0.data(as: Product.self )} )
        
        return essentials
    }
    
    static func fetchOtherProducts() async throws -> [Product] {
        let snapshot = try await Constant.productCollection.document(CategoryFilter.others.title).collection("product-list").getDocuments()
        var others = try snapshot.documents.compactMap( {try $0.data(as: Product.self )} )
        
        return others
    }
    
}
