//
//  Constant.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/4/24.
//

import SwiftUI
import Firebase

struct Constant {
    
    // Color Constant
    static let mainColor = Color("MainColor")
    static let brownColor = Color("BrownColor")
    
    // Firebase Constant
    static let userCollection = Firestore.firestore().collection("users")
    static let productCollection = Firestore.firestore().collection("products")
    static let transactionCollection = Firestore.firestore().collection("transactions")
    
    
}
