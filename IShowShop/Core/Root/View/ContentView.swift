//
//  ContentView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/4/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @StateObject var registrationViewModel = RegisterViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession == nil {
                LoginView()
                    .environmentObject(RegisterViewModel())
            } else if let currentUser = viewModel.currentUser{
                TabBarView(user: currentUser)
            }
        }
    }
}

#Preview {
    ContentView()
}
