//
//  Transaction.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/12/24.
//

import Foundation
import Firebase

struct Transaction: Codable, Identifiable, Hashable {
    let id: String
    let transactionCategory: String
    let amount: Double
    let timestamp: Timestamp
    var status: Bool? = false
    var deliveryAddress: String?
    var deliveryFee: Double?
    var discount: Double?
    var productId: String?
    var product: Product?
}

extension Transaction {
    static var MOCK_TRANSACTION: [Transaction] = [
        .init(id: NSUUID().uuidString, transactionCategory: TransactionFilter.topUp.title, amount: 150000, timestamp: Timestamp())
    ]
}
