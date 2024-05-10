//
//  CartView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/11/24.
//

import SwiftUI

struct CartView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(0 ... 10, id: \.self) { item in
                        CartCell(product: Product.MOCK_PRODUCT[0])
                    }
                    .navigationTitle("Cart")
                }
            }
        } 
    }
}

#Preview {
    CartView()
}
