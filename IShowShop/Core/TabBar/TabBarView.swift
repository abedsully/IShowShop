//
//  TabBarView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/4/24.
//

import SwiftUI

struct TabBarView: View {
    
    let user: User
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(user: user)
                .tabItem {
                    Label("Home", systemImage: selectedTab == 0 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                    
                }
                .onAppear{selectedTab = 0}
                .tag(0)
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .onAppear{selectedTab = 1}
                .tag(1)
            
            if user.isSuper {
                UploadProductView(tabIndex: $selectedTab)
                    .tabItem {
                        Label("Add Product", systemImage: selectedTab == 2 ? "plus.square.fill" : "plus.square")
                            .environment(\.symbolVariants, selectedTab == 2 ? .fill : .none)
                    }
                    .onAppear{selectedTab = 2}
                    .tag(2)
            } else {
                CartView()
                    .tabItem {
                        Label("Cart", systemImage: selectedTab == 2 ? "cart.fill" : "cart")
                            .environment(\.symbolVariants, selectedTab == 2 ? .fill : .none)
                    }
                    .onAppear{selectedTab = 2}
                    .tag(2)
            }

            
            NotificationView()
                .tabItem {
                    Label("Notifications", systemImage: selectedTab == 3 ? "bell.fill" : "bell")
                        .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                }
                .onAppear{selectedTab = 3}
                .tag(3)
            
            ProfileView(user: user)
                .tabItem {
                    Label("Profile", systemImage: selectedTab == 4 ? "person.fill" : "person")
                        .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
                }
                .onAppear{selectedTab = 4}
                .tag(4)
        }
        .tint(Constant.mainColor)
    }
}

#Preview {
    TabBarView(user: User.MOCK_USER[0])
}
