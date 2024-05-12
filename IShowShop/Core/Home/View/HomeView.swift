//
//  HomeView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/5/24.
//

import SwiftUI

struct HomeView: View {
    
    let user: User
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                SearchBarView()
                
                WalletView(user: user)
                    .padding(.horizontal, 10)
                
                // Most Purchased Items
                VStack (alignment: .leading){
                    Text("Most Purchased Items")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    ScrollView(.horizontal) {
                        HStack (spacing: 15){
                            ForEach(viewModel.mostPurchasedProducts, id: \.self) { product in
                                NavigationLink(value: product){
                                    ProductColumnView(product: product)
                                }
                                
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                .padding(.horizontal, 10)
                
                
                // Promo
                PromoView()
                    .padding(.vertical)
                
                // Highest Rated Items
                VStack (alignment: .leading){
                    Text("Highest Rated Items")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    ScrollView(.horizontal) {
                        HStack (spacing: 15){
                            ForEach(viewModel.products, id: \.self) { product in
                                NavigationLink(value: product) {
                                    VStack {
                                        ProductColumnView(product: product)
                                    }
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                .padding(.horizontal, 10)
                
            }
            .scrollIndicators(.hidden)
            .padding(.top)
            .navigationDestination(for: Product.self) { product in
                ProductDetailView(product: product)
            }
        }
        .refreshable {
            
            Task {
                try await viewModel.fetchMostBoughtProducts()
            }
            
            Task {
                try await viewModel.fetchPosts()
            }
        }
        
    }
}


#Preview {
    HomeView(user: User.MOCK_USER[0])
}
