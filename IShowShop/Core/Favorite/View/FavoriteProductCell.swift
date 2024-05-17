//
//  FavoriteProductCell.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/16/24.
//

import SwiftUI
import Kingfisher


struct FavoriteProductCell: View {
    @StateObject var viewModel =  FavoriteProductViewModel()
    @ObservedObject var viewModel2: ProductViewModel

    
    private var product: Product {
        return viewModel2.product
    }
    
    init(product: Product) {
        self.viewModel2 = ProductViewModel(product: product)
    }
    
    private var isFavorite: Bool {
        return product.isFavorite ?? false
    }
    
    var body: some View {
        VStack {
            HStack (alignment: .top, spacing: 16) {
                KFImage(URL(string: product.productImageURL))
                    .resizable()
                    .frame(width: 120, height: 120)
                    .scaledToFill()
                    .background(Color(.systemGray6))
                
                VStack (alignment: .leading, spacing: 5){
                    Text(product.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                    
                    Text(product.category)
                    
                    PriceFormatter(price: product.price)
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                
                if isFavorite {
                    Spacer()
                    
                    Image(systemName: "heart.fill")
                        .imageScale(.large)
                        .foregroundStyle(.red)
                }
            }
            .font(.subheadline)
            .padding(.horizontal, 16)
            
            Divider()
        }
        .foregroundStyle(Constant.textColor)
        .padding(.vertical, 8)
        .onAppear {
            Task {
                try await viewModel.fetchFavoriteProducts()
            }
            
            Task {
                try await viewModel2.checkIfUserLikedProduct()
            }
        }
    }
}

#Preview {
    FavoriteProductCell(product: Product.MOCK_PRODUCT[0])
}
