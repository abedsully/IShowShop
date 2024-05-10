//
//  ProfileViewModel.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/10/24.
//

import Foundation

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
}
