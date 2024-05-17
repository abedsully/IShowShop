//
//  FavoriteProductView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/16/24.
//

import SwiftUI

struct FavoriteProductView: View {
    let user: User
    @ObservedObject var viewModel: FavoriteProductViewModel
    @State private var isLoading = false
    @Environment (\.dismiss) var dismiss
    
    init(user: User) {
        self.user = user
        self.viewModel = FavoriteProductViewModel()
    }
    
    
    var body: some View {
        NavigationStack {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
                    .frame(width: 50, height: 50)
            } else {
                ScrollView {
                    LazyVStack {
                        if viewModel.favoriteProducts.isEmpty {
                            Text("You have no favorite products")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding()
                        } else {
                            ForEach(viewModel.favoriteProducts, id: \.self) { product in
                                NavigationLink(value: product) {
                                    FavoriteProductCell(product: product)
                                }
                            }
                        }
                    }
                    .navigationTitle("Favorite Product")
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "chevron.left")
                                    .foregroundStyle(.black)
                            }
                        }
                    }
                }
                .navigationDestination(for: Product.self) { product in
                    ProductDetailView(user: user, product: product)
                }
            }
            
        }
        .onAppear {
            isLoading.toggle()
            Task {
                defer { isLoading = false }
                try await viewModel.fetchFavoriteProducts()
            }
        }
        .refreshable {
            Task {
                try await viewModel.fetchFavoriteProducts()
            }
        }
    }
}

#Preview {
    FavoriteProductView(user: User.MOCK_USER[0])
}
