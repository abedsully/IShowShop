//
//  CartView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/11/24.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: CartViewModel
    @State private var isLoading = false
    
    private var user: User {
        return viewModel.user
    }
    
    init(user: User) {
        self.viewModel = CartViewModel(user: user)
    }
    

    var body: some View {
        NavigationStack {
            ScrollView {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2)
                        .frame(width: 50, height: 50)
                } else {
                    LazyVStack {
                        if viewModel.productInCartList.isEmpty {
                            Text("Cart is empty")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding()
                        } else {
                            ForEach(viewModel.productInCartList, id: \.self) { product in
                                NavigationLink(value: product) {
                                    CartCell(product: product)
                                }
                            }
                        }
                    }
                    .navigationTitle("Cart")
                }
            }
            .navigationDestination(for: Product.self) { product in
                OrderView(user: user, product: product)
            }
        }
        .onAppear {
            isLoading.toggle()
            Task {
                defer { isLoading = false }
                try await viewModel.fetchProductsInCart()
            }
        }
        .refreshable {
            Task {
                try await viewModel.fetchProductsInCart()
            }
        }
    }
}



#Preview {
    CartView(user: User.MOCK_USER[0])
}
