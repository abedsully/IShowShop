//
//  ProductService.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/11/24.
//

import Foundation
import Firebase

struct ProductService {
    
    
    static func fetchAllProducts() async throws -> [Product] {
        var allProducts: [Product] = []
        
        for category in CategoryFilter.allCases {
            let snapshot = try await Constant.productCollection.document(category.title).collection("product-list").getDocuments()
            let products = try snapshot.documents.compactMap { try $0.data(as: Product.self) }
            allProducts.append(contentsOf: products)
        }
        
        return allProducts
    }
    
    static func fetchMostPurchasedProducts() async throws -> [Product] {
        var mostPurchasedProducts: [Product] = []
        
        for category in CategoryFilter.allCases {
            let snapshot = try await Constant.productCollection.document(category.title).collection("product-list").getDocuments()
            let products = try snapshot.documents.compactMap( {try $0.data(as: Product.self) } )
            mostPurchasedProducts.append(contentsOf: products)
        }
        
        mostPurchasedProducts.sort(by: { $0.sold > $1.sold })
        
        return mostPurchasedProducts
    }
    
    static func fetchMostFavoriteProducts() async throws -> [Product] {
        var mostFavoriteProduct: [Product] = []
        
        for category in CategoryFilter.allCases {
            let snapshot = try await Constant.productCollection.document(category.title).collection("product-list").getDocuments()
            let products = try snapshot.documents.compactMap( {try $0.data(as: Product.self) } )
            mostFavoriteProduct.append(contentsOf: products)
        }
        
        mostFavoriteProduct.sort(by: { $0.likesCount > $1.likesCount })
        
        return mostFavoriteProduct
    }

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
    
    static func fetchCartList() async throws -> [Product] {
        var productsInCart: [Product] = []
        
        guard let uid = Auth.auth().currentUser?.uid else {return []}
        let userCartList = try await Constant.userCollection.document(uid).collection("cart-list").getDocuments()
        let productList = userCartList.documents.map( {$0.documentID} )
        
        if productList.isEmpty {
            return []
        }
        
        for category in CategoryFilter.allCases {
            let addedToCartProduct = try await Constant.productCollection.document(category.title).collection("product-list").whereField("id", in: productList).getDocuments()
            let products = try addedToCartProduct.documents.compactMap( {try $0.data(as: Product.self) } )
            productsInCart.append(contentsOf: products)
        }
        
        
        return productsInCart
    }
    
    static func fetchProduct(productId: String) async throws -> Product? {
        var productSnapshot: DocumentSnapshot?
        
        for category in CategoryFilter.allCases {
            productSnapshot = try await Constant.productCollection.document(category.title).collection("product-list").document(productId).getDocument()
            
            if let snapshot = productSnapshot, snapshot.exists {
                break
            }
        }
        
        return try productSnapshot?.data(as: Product.self)
    }

}
