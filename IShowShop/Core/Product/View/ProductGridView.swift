//
//  ProductGridView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/10/24.
//

import SwiftUI

struct ProductGridView: View {
    let product: Product
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 4),
        .init(.flexible(), spacing: 4),
    ]
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 2) - 1
    
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 4) {
            ForEach(0 ... 10, id: \.self) { content in
                NavigationLink(value: product) {
                    VStack (alignment: .leading){
                        Image("logo")
                            .resizable()
                            .scaledToFill()
                            .background(Color(.systemGray6))
                            
                        
                        VStack (alignment: .leading) {
                            HStack {
                                Text(product.category)
                                    .font(.subheadline)
                                    .foregroundStyle(Color(.systemGray2))
                                
                                Spacer()
                                Button {
                                    
                                } label: {
                                    Image(systemName: "heart.fill")
                                        .foregroundStyle(.red)
                                }
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
                }
            }
        }
        .navigationDestination(for: Product.self) { product in
            ProductDetailView(product: product)
        }
    }
}

#Preview {
    ProductGridView(product: Product.MOCK_PRODUCT[0])
}
