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
    @Published var currentUser: User?
    
    static let shared = AuthService()
    
    init() {
        Task {
            try await loadUserData()
        }
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            // Await used here because we need to get the value of result first before setting
            // the user session as result.user
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await loadUserData()
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(email: String, password: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            await uploadUserData(uid: result.user.uid, email: email, username: username, balance: 0, isSuper: false)
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func loadUserData() async throws {
        self.userSession = Auth.auth().currentUser
        guard let currentUid = userSession?.uid else {return}
        let snapshot = try await Constant.userCollection.document(currentUid).getDocument()
        // Decoding to user object
        self.currentUser = try? snapshot.data(as: User.self)
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
        self.currentUser = nil
    }
    
    private func uploadUserData(uid: String, email: String, username: String, balance: Double, isSuper: Bool) async {
        let user = User(id: uid, email: email, username: username, balance: balance, isSuper: isSuper)
        self.currentUser = user
        guard let encodedUser = try? Firestore.Encoder().encode(user) else {return}
        try? await Constant.userCollection.document(user.id).setData(encodedUser)
    }
}
