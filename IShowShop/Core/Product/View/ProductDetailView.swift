//
//  ProductDetailView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/10/24.
//

import SwiftUI
import Kingfisher

struct ProductDetailView: View {
    
    @ObservedObject var viewModel: ProductViewModel
    @Environment (\.dismiss) var dismiss


    init(product: Product) {
        self.viewModel = ProductViewModel(product: product)
    }
    
    var product: Product {
        return viewModel.product
    }
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .topTrailing){
                KFImage(URL(string: product.productImageURL))
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: 400)
                    .scaledToFill()
                    .background(Color(.systemGray6))
                
                Image(systemName: "heart.fill")
                    .foregroundStyle(.red)
                    .imageScale(.large)
                    .padding(.top, 20)
                    .padding(.trailing, 20)
            }
            
            VStack (alignment: .leading) {
                VStack (alignment: .leading, spacing: 16){
                    Text(product.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    VStack (alignment: .leading){
                        Text("Description")
                            .font(.title3)
                            .fontWeight(.medium)
                        
                        Text(product.description)
                    }
                    
                    PromoView()
                    
                    HStack {
                        PriceFormatter(price: product.price)
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                        
                        
                        Spacer()
                        
                        Text("Stock: \(product.stock)")
                    }
                    .padding(.horizontal)
                    
                    Button {
                        Task {
                            try await viewModel.addToCart()
                            dismiss()
                        }
                    
                    } label : {
                        Text("Add To Cart")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: UIScreen.main.bounds.width - 16, height: 44)
                            .background(Constant.mainColor)
                            .cornerRadius(8)
                    }
                    .padding(.vertical)
                    
                }
                .padding(.horizontal)
                
            }    
        }
        .scrollIndicators(.hidden)
        
    }
}

#Preview {
    ProductDetailView(product: Product.MOCK_PRODUCT[0])
}
