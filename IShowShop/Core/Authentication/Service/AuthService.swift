//
//  AuthService.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/6/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func login(withEmail email: String, password: String) async throws {
        
    }
    
    func createUser(email: String, password: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    func loadUserData() async throws {
        
    }
    
    func signOut() {
        
    }
    
//    @MainActor
//    private func uploadUserData(uid: String, email: String, username: String, balance: Double, isSuper: Bool) {
//        guard let currentUid = Auth
//    }
}
