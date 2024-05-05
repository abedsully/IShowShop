//
//  HomeView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/5/24.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedCategory: CategoryFilter = .clothes
    
    var body: some View {
        SearchBarView()
        
        WalletView()
            .padding(.horizontal, 10)
        
        // Most Purchased Items
        VStack (alignment: .leading){
            Text("Most Purchased Items")
                .font(.title2)
                .fontWeight(.semibold)
            
            ScrollView(.horizontal) {
                HStack (spacing: 15){
                    ForEach(0 ... 10, id: \.self) { items in
                        VStack {
                            Image("category")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            Text("Denim Jacket")
                                .font(.footnote)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal, 10)
        
        
        // Promo
        PromoView()
        
        // Highest Rated Items
        VStack (alignment: .leading){
            Text("Highest Rated Items")
                .font(.title2)
                .fontWeight(.semibold)
            
            ScrollView(.horizontal) {
                HStack (spacing: 15){
                    ForEach(0 ... 10, id: \.self) { items in
                        VStack {
                            Image("category")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            Text("Denim Jacket")
                                .font(.footnote)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal, 10)

    }
}

#Preview {
    HomeView()
}
