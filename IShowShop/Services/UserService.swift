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
        
        async let _ = try await Constant.userCollection.document(uid).updateData(["balance": user.balance + topUpValue])
    }
}
