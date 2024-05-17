//
//  SearchContentListView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/5/24.
//

import SwiftUI

struct SearchContentListView: View {

    let user: User
    @StateObject var viewModel = SearchViewModel()
    @State private var selectedCategory: CategoryFilter = .clothes
    @State private var inputProducts = ""
    @State private var showFavoriteProduct = false
    
    var body: some View {
        VStack {

            SearchBarView(user: user, inputProducts: $inputProducts)
            
            ScrollView(.horizontal) {
                HStack (spacing: 10){
                    ForEach(CategoryFilter.allCases) { category in
                        Text(category.title)
                            .font(.subheadline)
                            .frame(height: 40)
                            .padding(.horizontal)
                            .background(Color(.systemGray5))
                            .foregroundStyle(Constant.textColor)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .onTapGesture {
                                selectedCategory = category
                                inputProducts = ""
                            }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(.vertical)
        .padding(.leading)
        
        LazyVStack {
            switch selectedCategory {
            case .clothes:
                ProductGridView(user: user, products: viewModel.clothes, searchQuery: $inputProducts)
            case .shoes:
                ProductGridView(user: user, products: viewModel.shoes, searchQuery: $inputProducts)
            case .electronics:
                ProductGridView(user: user, products: viewModel.electronics, searchQuery: $inputProducts)
            case .essentials:
                ProductGridView(user: user, products: viewModel.essentials, searchQuery: $inputProducts)
            case .others:
                ProductGridView(user: user, products: viewModel.others, searchQuery: $inputProducts)
            }
        }
    }
}

#Preview {
    SearchContentListView(user: User.MOCK_USER[0])
}
