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
        let transaction = Transaction(id: ref.documentID, transactionCategory: TransactionFilter.topUp.title, amount: topUpValue, timestamp: Timestamp())
        guard let transactionData = try? Firestore.Encoder().encode(transaction) else {return}
        try await ref.setData(transactionData)
    }
}
