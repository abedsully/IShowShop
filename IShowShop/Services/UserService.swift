//
//  UserService.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/12/24.
//

import Foundation
import Firebase

struct UserService {
    
    static var shared = UserService()
    
    @MainActor
    func topUpBalance(value: String, user: User) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let topUpValue = Double(value) ?? 0.0
        
        // Updates value in user collections
        async let _ = try await Constant.userCollection.document(uid).updateData(["balance": user.balance + topUpValue])
        
        // Add topup transaction to transaction collections
        let ref = Constant.transactionCollection.document(uid).collection(TransactionFilter.topUp.title).document()
        let transaction = Transaction(id: ref.documentID, transactionCategory: TransactionFilter.topUp.title, amount: topUpValue, timestamp: Timestamp(), userId: uid)
        guard let transactionData = try? Firestore.Encoder().encode(transaction) else {return}
        try await ref.setData(transactionData)
    }
    
    @MainActor
    func fetchAllUsers() async throws -> [User] {
        let snapshot = try await Constant.userCollection.getDocuments()
        
        return snapshot.documents.compactMap( {try? $0.data(as: User.self)})
    }
    
    @MainActor
    func addToCart(_ product: Product) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        async let _ = Constant.userCollection.document(uid).collection("cart-list").document(product.id).setData([:])
    }
    
    @MainActor
    func removeFromCart(_ product: Product) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        async let _ = Constant.userCollection.document(uid).collection("cart-list").document(product.id).delete()
    }
    
    @MainActor
    func addDeliveryAddress(address: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let ref = Constant.userCollection.document(uid).collection("user-address").document()
        let addressValue = Address(id: ref.documentID, address: address)
        
        guard let addressData = try? Firestore.Encoder().encode(addressValue) else {return}
        
        try await ref.setData(addressData)
    }
    
    @MainActor
    func likeProduct(_ product: Product) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        async let _ = try await Constant.productCollection.document(product.category).collection("product-list").document(product.id).collection("product-likes").document(uid).setData([:])
        
        async let _ = try await Constant.productCollection.document(product.category).collection("product-list").document(product.id).updateData(["likesCount": product.likesCount + 1])
        
        async let _ = try await Constant.userCollection.document(uid).collection("user-likes").document(product.id).setData([:])
    }
    
    @MainActor
    func unlikeProduct(_ product: Product) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        async let _ = try await Constant.productCollection.document(product.category).collection("product-list").document(product.id).collection("product-likes").document(uid).delete()
        
        async let _ = try await Constant.productCollection.document(product.category).collection("product-list").document(product.id).updateData(["likesCount": product.likesCount - 1])
        
        async let _ = try await Constant.userCollection.document(uid).collection("user-likes").document(product.id).delete()
    }
    
    @MainActor
    func checkIfProductIsFavoriteByUser(_ product: Product) async throws -> Bool {
        guard let uid = Auth.auth().currentUser?.uid else {return false}
        
        let snapshot = try await Constant.userCollection.document(uid).collection("user-likes").document(product.id).getDocument()
        
        return snapshot.exists
    }
    
    @MainActor
    func fetchUserFavoriteProduct() async throws -> [Product] {
        
        var favoriteProducts: [Product] = []
        
        guard let uid = Auth.auth().currentUser?.uid else {return []}
        let userFavoriteSnapshot = try await Constant.userCollection.document(uid).collection("user-likes").getDocuments()
        let likedProductId = userFavoriteSnapshot.documents.map( {$0.documentID} )
        if likedProductId.isEmpty {return []}
        
        for category in CategoryFilter.allCases {
            let likedProductSnapshot = try await Constant.productCollection.document(category.title).collection("product-list").whereField("id", in: likedProductId).getDocuments()
            var products = try likedProductSnapshot.documents.compactMap( {try $0.data(as: Product.self)} )
            favoriteProducts.append(contentsOf: products)
        }
        
        return favoriteProducts
    }
}
