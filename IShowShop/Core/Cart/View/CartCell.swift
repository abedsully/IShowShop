//
//  CartCell.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/11/24.
//

import SwiftUI

struct CartCell: View {
    let product: Product
    
    var body: some View {
        VStack {
            HStack (alignment: .top, spacing: 16) {
                Image("logo")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .scaledToFill()
                    .background(Color(.systemGray6))
                
                VStack (alignment: .leading, spacing: 5){
                    Text(product.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text(product.category)
                    
                    PriceFormatter(price: product.price)
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.black)
                }
                
            }
            .font(.subheadline)
            .padding(.horizontal, 16)
            
            Divider()
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    CartCell(product: Product.MOCK_PRODUCT[0])
}
