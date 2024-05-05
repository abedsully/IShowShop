//
//  TabBarView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/4/24.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
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
            
            Text("Cart View")
                .tabItem {
                    Label("Cart", systemImage: selectedTab == 2 ? "cart.fill" : "cart")
                        .environment(\.symbolVariants, selectedTab == 2 ? .fill : .none)
                }
                .onAppear{selectedTab = 2}
                .tag(2)
            
            Text("Notifications View")
                .tabItem {
                    Label("Notifications", systemImage: selectedTab == 3 ? "bell.fill" : "bell")
                        .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                }
                .onAppear{selectedTab = 3}
                .tag(3)
            
            ProfileView()
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
    TabBarView()
}
