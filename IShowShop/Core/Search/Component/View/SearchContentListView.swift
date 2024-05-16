//
//  SearchContentListView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/5/24.
//

import SwiftUI

struct SearchContentListView: View {

    @StateObject var viewModel = SearchViewModel()
    @State private var selectedCategory: CategoryFilter = .clothes
    @State private var inputProducts = ""
    @State private var showFavoriteProduct = false
    
    var body: some View {
        VStack {

            SearchBarView(inputProducts: $inputProducts)
            
            ScrollView(.horizontal) {
                HStack (spacing: 10){
                    ForEach(CategoryFilter.allCases) { category in
                        Text(category.title)
                            .font(.subheadline)
                            .frame(height: 40)
                            .padding(.horizontal)
                            .background(Color(.systemGroupedBackground))
                            .foregroundStyle(.black)
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
                ProductGridView(products: viewModel.clothes, searchQuery: $inputProducts)
            case .shoes:
                ProductGridView(products: viewModel.shoes, searchQuery: $inputProducts)
            case .electronics:
                ProductGridView(products: viewModel.electronics, searchQuery: $inputProducts)
            case .essentials:
                ProductGridView(products: viewModel.essentials, searchQuery: $inputProducts)
            case .others:
                ProductGridView(products: viewModel.others, searchQuery: $inputProducts)
            }
        }
    }
}

#Preview {
    SearchContentListView()
}
