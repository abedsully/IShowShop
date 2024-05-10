//
//  ProductCell.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/10/24.
//

import SwiftUI

struct ProductCell: View {
    let product: Product
    
    var body: some View {
        VStack (alignment: .leading){
            Image("logo")
                .resizable()
                .frame(width: 200, height: 200)
                .scaledToFit()
            
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
            
            PriceFormatter(price: product.price)
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .clipShape(Rectangle())
        .background(Constant.mainColor)
        .frame(width: 200)
    }
}

#Preview {
    ProductCell(product: Product.MOCK_PRODUCT[0])
}
