//
//  RegisterViewModel.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/7/24.
//

import Foundation

class RegisterViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var username = ""
    @Published var password = ""
    
    @MainActor
    func createUser() async throws {
        try await AuthService.shared.createUser(email: email, password: password, username: username)
        
        username = ""
        email = ""
        password = ""
    }
    
    
}
