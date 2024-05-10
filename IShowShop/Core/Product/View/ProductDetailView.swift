//
//  ProductDetailView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/10/24.
//

import SwiftUI

struct ProductDetailView: View {
    
    let product: Product
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading){
                ZStack(alignment: .topTrailing){
                    Image("logo")
                        .resizable()
                        .frame(height: 400)
                        .scaledToFill()
                        .background(Color(.systemGray6))
                    
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.red)
                        .imageScale(.large)
                        .padding(.top, 20)
                        .padding(.trailing, 20)
                }
                
                VStack (alignment: .leading, spacing: 16){
                    Text(product.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    VStack (alignment: .leading){
                        Text("Description")
                            .font(.title3)
                            .fontWeight(.medium)
                        
                        Text("\(product.description) asdsajdijasidj asd iasjdiajs ijadsia idjsai disjd iasjid iasjdi asid asijdi ajsdi sajdija si ijsiadjaidj iasjd iajsdi asijd ia s")
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
        
    }
}

#Preview {
    ProductDetailView(product: Product.MOCK_PRODUCT[0])
}
