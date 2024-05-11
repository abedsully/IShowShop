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
    let category: String
    var stock: Int
    var sold: Int
    var size: String?
    var colour: String?
    
    var didLike: Bool? = false
}

extension Product {
    static var MOCK_PRODUCT: [Product] = [
        .init(id: NSUUID().uuidString, name: "Uniqlo Stretch Shirt", price: 100000, description: "Baju bagus", productImageURL: "category", category: "Clothes", stock: 10, sold: 0)
    ]
}
