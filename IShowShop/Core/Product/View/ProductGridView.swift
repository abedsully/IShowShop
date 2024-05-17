//
//  ProductGridView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/10/24.
//

import SwiftUI
import Kingfisher

struct ProductGridView: View {
    
    let user: User
    var products: [Product]
    @Binding var searchQuery: String
    
    @StateObject var viewModel = SearchViewModel()
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 4),
        .init(.flexible(), spacing: 4),
    ]
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 2) - 1
    
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 4) {
            ForEach(searchQuery.isEmpty ? products : viewModel.filteredProducts(searchQuery) , id: \.self) { product in
                NavigationLink(value: product) {
                    VStack (alignment: .leading){
                        KFImage(URL(string: product.productImageURL))
                            .resizable()
                            .scaledToFit()
                            .frame(width: imageDimension, height: imageDimension)
                            .background(Color(.systemGray6))
                        
                        VStack (alignment: .leading) {
                            HStack {
                                Text(product.category)
                                    .font(.subheadline)
                                    .foregroundStyle(Color(.systemGray2))
                            }
                            .padding(.bottom, 10)
                            
                            
                            Text(product.name)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                                
                            
                            PriceFormatter(price: product.price)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                        }
                        .padding(10)
                        .foregroundStyle(.black)
                        .background(.white)
                    }
                    .frame(height: imageDimension + 120)
                    .border(Color(.systemGray4), width: 1)
                }
            }
        }
        .navigationDestination(for: Product.self) { product in
            ProductDetailView(user: user, product: product)
        }
    }
}
