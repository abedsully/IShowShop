//
//  TransactionService.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/12/24.
//

import Foundation
import Firebase

struct TransactionService {
    
    static var shared = TransactionService()
    
    func fetchTransactions() async throws -> [Transaction] {
        var transactionLists: [Transaction] = []
        guard let uid = Auth.auth().currentUser?.uid else { return [] }
        
        let topupSnapshot = try await Constant.transactionCollection.document(uid).collection(TransactionFilter.topUp.title).getDocuments()
        let topupTransactions = try topupSnapshot.documents.compactMap { try $0.data(as: Transaction.self) }
        transactionLists.append(contentsOf: topupTransactions)
        
        let orderSnapshot = try await Constant.transactionCollection.document(uid).collection(TransactionFilter.order.title).getDocuments()
        var orderTransactions = try orderSnapshot.documents.compactMap { try $0.data(as: Transaction.self) }
        
        for i in 0 ..< orderTransactions.count {
            let transaction = orderTransactions[i]
            let productId = transaction.productId ?? ""
            let product = try await ProductService.fetchProduct(productId: productId)
            orderTransactions[i].product = product
        }
        transactionLists.append(contentsOf: orderTransactions)
        
        transactionLists.sort(by: { $0.timestamp.compare($1.timestamp) == .orderedDescending })
        
        
        return transactionLists
    }
    
    func fetchOrders() async throws -> [Transaction] {
        var orderLists: [Transaction] = []
        
        guard let uid = Auth.auth().currentUser?.uid else {return []}
        
        let orderSnapshot = try await Constant.transactionCollection.document(uid).collection(TransactionFilter.order.title).getDocuments()
        var orderTransactions = try orderSnapshot.documents.compactMap { try $0.data(as: Transaction.self) }
        for i in 0 ..< orderTransactions.count {
            let transaction = orderTransactions[i]
            let productId = transaction.productId ?? ""
            let product = try await ProductService.fetchProduct(productId: productId)
            orderTransactions[i].product = product
        }
        orderLists.append(contentsOf: orderTransactions)
        
        orderLists.sort(by: { $0.timestamp.compare($1.timestamp) == .orderedDescending })
        orderLists.sort { !$0.status! && $1.status! }
        
        return orderLists
    }
    
    func fetchUserAddress() async throws -> [Address] {
        guard let uid = Auth.auth().currentUser?.uid else {return []}
        
        let snapshot = try await Constant.userCollection.document(uid).collection("user-address").getDocuments()
        
        var addresses = try snapshot.documents.compactMap( {try $0.data(as: Address.self) } )
        
        return addresses
    }
    
    func checkoutOrder(user: User, product: Product, category: String, amount: Double, deliveryAddress: String, deliveryFee: Double, discount: Double, quantity: Double) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        // Adding New Transaction Collection
        let ref = Constant.transactionCollection.document(uid).collection(category).document()
        
        let transaction = Transaction(id: ref.documentID, transactionCategory: category, amount: amount, timestamp: Timestamp(), userId: uid, quantity: quantity, status: false, deliveryAddress: deliveryAddress, deliveryFee: deliveryFee, discount: discount, productId: product.id)
        guard let transactionData = try? Firestore.Encoder().encode(transaction) else {return}
        try await ref.setData(transactionData)
        
        // Deducing user's balance
        async let _ = try await Constant.userCollection.document(uid).updateData(["balance": user.balance - amount])
        
        // Deleting the product from the user's cart
        async let _ = try await Constant.userCollection.document(uid).collection("cart-list").document(product.id).delete()
        
        // Adding sold variable by 1 and reducing stock by 1
        async let _ = try await Constant.productCollection.document(product.category).collection("product-list").document(product.id).updateData(["sold": product.sold + Int(quantity), "stock": product.stock - Int(quantity)])
        
        let productOwnerUser = try await Constant.userCollection.document(product.productOwnerId).getDocument(as: User.self)
        
        async let _ = try await Constant.userCollection.document(productOwnerUser.id).updateData(["balance": productOwnerUser.balance + amount])
    }
    
    func fetchAllOrders() async throws -> [Transaction] {
        
        var orderList: [Transaction] = []
        
        let users = try await UserService.shared.fetchAllUsers()
        
        for user in users {
            let snapshot = try await Constant.transactionCollection.document(user.id).collection(TransactionFilter.order.title).getDocuments()
            var allOrder = try snapshot.documents.compactMap( {try $0.data(as: Transaction.self) })
            
            for i in 0 ..< allOrder.count {
                let order = allOrder[i]
                let productId = order.productId ?? ""
                let products = try await ProductService.fetchProduct(productId: productId)
                allOrder[i].product = products
            }
            orderList.append(contentsOf: allOrder)
        }
        orderList.sort { (transaction1, transaction2) -> Bool in
            if let date1 = transaction1.deliveryCompleteDate, let date2 = transaction2.deliveryCompleteDate {
                return date1.compare(date2) == .orderedDescending
            } else {
                return transaction1.timestamp.compare(transaction2.timestamp) == .orderedDescending
            }
        }
        orderList.sort { !$0.status! && $1.status! }
        
        return orderList
    }
    
    func completeOrder(buyerId: String, transactionId: String) async throws {
        async let _ = try await Constant.transactionCollection.document(buyerId).collection(TransactionFilter.order.title).document(transactionId).updateData(["status": true, "deliveryCompleteDate": Timestamp()])
    }
    
}
