//
//  ProductDetailView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/10/24.
//

import SwiftUI
import Kingfisher
import Firebase

struct ProductDetailView: View {
    
    @ObservedObject var viewModel: ProductViewModel
    @Environment (\.dismiss) var dismiss
    
    let user: User
    
    init(user: User, product: Product) {
        self.user = user
        self.viewModel = ProductViewModel(product: product)
    }
    
    var product: Product {
        return viewModel.product
    }
    
    private var isFavorite: Bool {
        return product.isFavorite ?? false
    }
    
    var body: some View {
        ScrollView {
            KFImage(URL(string: product.productImageURL))
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: 400)
                .scaledToFill()
                .background(Color(.systemGray6))
            
            
            VStack (alignment: .leading) {
                VStack (alignment: .leading, spacing: 16){
                    
                    HStack {
                        Text(product.name)
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Button {
                            handleLikedButtonTapped()
                        } label: {
                            Image(systemName: isFavorite ? "heart.fill": "heart")
                                .foregroundStyle(isFavorite ? .red : .black)
                                .imageScale(.large)
                        }
                    }
                    
                    Text("Description")
                        .font(.title3)
                        .fontWeight(.medium)
                    
                    Text(product.description)
                    
                    PromoView()
                    
                    HStack {
                        PriceFormatter(price: product.price)
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                        
                        
                        Spacer()
                        
                        Text("Stock: \(product.stock)")
                    }
                    .padding(.horizontal)
                    
                    if !user.isSuper {
                        Button {
                            Task {
                                try await viewModel.addToCart()
                            }
                            
                        } label : {
                            Text(product.stock == 0 ? "Out of Stock" : "Add to Cart")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(width: UIScreen.main.bounds.width - 16, height: 44)
                                .background(product.stock == 0 ? Color.gray : Constant.mainColor)
                                .cornerRadius(8)
                        }
                        .disabled(product.stock == 0)
                        .padding(.vertical)
                    }
                }
                .padding(.horizontal)
                
            }
        }
        .scrollIndicators(.hidden)
    }
    
    func handleLikedButtonTapped() {
        Task {
            if isFavorite {
                try await viewModel.removeFromFavorite()
            } else {
                try await viewModel.addToFavorite()
            }
        }
    }
    
}

#Preview {
    ProductDetailView(user: User.MOCK_USER[0], product: Product.MOCK_PRODUCT[0])
}
