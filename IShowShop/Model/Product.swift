//
//  Product.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/10/24.
//

import Foundation

struct Product: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let price: Double
    let description: String
    let productImageURL: String
    var stock: Int
    var didLike: Bool? = false
}

extension Product {
    static var MOCK_PRODUCT: [Product] = [
        .init(id: NSUUID().uuidString, name: "Baju", price: 100000, description: "Baju bagus", productImageURL: "category", stock: 10)
    ]
}
