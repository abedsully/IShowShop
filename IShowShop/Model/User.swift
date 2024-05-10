//
//  User.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/6/24.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let email: String
    var username: String
    var balance: Double
    var isSuper: Bool
    var fullName: String?
    var profileImageURL: String?
}

extension User {
    static var MOCK_USER: [User] = [
        .init(id: NSUUID().uuidString, email: "abed@gmail.com", username: "abedsully", balance: 0, isSuper: false, profileImageURL: "sample_profile")
    ]
}
