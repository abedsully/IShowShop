//
//  SearchContentListView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/5/24.
//

import SwiftUI

struct SearchContentListView: View {
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
                ProductGridView(product: Product.MOCK_PRODUCT[0])
            case .shoes:
                Text("Shoes")
            case .electronics:
                Text("Electronics")
            case .essentials:
                Text("Essentials")
            case .others:
                Text("Others")
            }
        }
    }
}

#Preview {
    SearchContentListView()
}
