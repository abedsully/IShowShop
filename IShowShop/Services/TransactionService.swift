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
        guard let uid = Auth.auth().currentUser?.uid else {return []}
        
        for transaction in TransactionFilter.allCases {
            let snapshot = try await Constant.transactionCollection.document(uid).collection(transaction.title).getDocuments()
            let transactions = try snapshot.documents.compactMap( {try $0.data(as: Transaction.self)} )
            transactionLists.append(contentsOf: transactions)
        }
        
        transactionLists.sort(by: {$0.timestamp.compare($1.timestamp) == .orderedDescending})
        
        return transactionLists
    }
}
