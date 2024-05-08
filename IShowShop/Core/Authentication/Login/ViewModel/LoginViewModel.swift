//
//  LoginViewModel.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/8/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    
    func login() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
