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
    @State private var showFavoriteProduct = false
    @State private var text = ""
    @Binding var tabIndex: Int
    
    init(user: User, tabIndex: Binding<Int>) {
        self.user = user
        _tabIndex = tabIndex
    }
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    Button {
                        tabIndex = 1
                    } label: {
                        HStack(spacing: 0) {
                            Image(systemName: "magnifyingglass")
                            
                            TextField("Search products here", text: $text)
                                .padding(.leading, -75)
                            
                            Spacer()
                            
                            Image(systemName: "mic.fill")
                        }
                        .padding(.horizontal)
                        .frame(height: 40)
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(8)
                    }
                    
                    Button {
                        showFavoriteProduct.toggle()
                    } label: {
                        Image(systemName: "heart.fill")
                            .padding(.leading, 10)
                    }
                    .fullScreenCover(isPresented: $showFavoriteProduct, content: {
                        FavoriteProductView(user: user)
                    })
                }
                .padding(.bottom)
                .padding(.horizontal)
                .foregroundStyle(.black)
                
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
                                    ProductColumnView(user: user, product: product)
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
                                        ProductColumnView(user: user, product: product)
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
                ProductDetailView(user: user, product: product)
            }
        }
        .onAppear {
            Task {
                async let _ = try await AuthService.shared.loadUserData()
            }
        }
        .refreshable {
            
            Task {
                async let _ = try await AuthService.shared.loadUserData()
                async let _ = try await viewModel.fetchMostBoughtProducts()
                async let _ = try await viewModel.fetchPosts()
            }
        }
        
    }
}


#Preview {
    HomeView(user: User.MOCK_USER[0], tabIndex: .constant(0))
}
