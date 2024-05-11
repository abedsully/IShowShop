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
    
    var body: some View {
        VStack {
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
                ProductGridView(products: viewModel.clothes)
            case .shoes:
                ProductGridView(products: viewModel.shoes)
            case .electronics:
                ProductGridView(products: viewModel.electronics)
            case .essentials:
                ProductGridView(products: viewModel.essentials)
            case .others:
                ProductGridView(products: viewModel.others)
            }
        }
    }
}

#Preview {
    SearchContentListView()
}
