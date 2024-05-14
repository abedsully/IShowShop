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
    let productOwnerId: String
    var productOwner: User?
    var stock: Int
    var sold: Int
    var likesCount: Int
    
    var isFavorite: Bool? = false
}

extension Product {
    static var MOCK_PRODUCT: [Product] = [
        .init(id: NSUUID().uuidString, name: "Uniqlo Stretch Shirt", price: 250000, description: "Baju bagus", productImageURL: "logo", category: "Clothes", productOwnerId: NSUUID().uuidString, stock: 10, sold: 0, likesCount: 0)
    ]
}
