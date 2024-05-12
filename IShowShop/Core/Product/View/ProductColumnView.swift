//
//  ProductColumnView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/10/24.
//

import SwiftUI
import Kingfisher

struct ProductColumnView: View {
    let product: Product
    
    
    var body: some View {
        VStack {
            KFImage(URL(string: product.productImageURL))
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            PriceFormatter(price: product.price)
                .font(.footnote)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    ProductColumnView(product: Product.MOCK_PRODUCT[0])
}
