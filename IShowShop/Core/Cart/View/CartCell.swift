//
//  CartCell.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/11/24.
//

import SwiftUI
import Kingfisher

struct CartCell: View {
    
    let product: Product
    
    @ObservedObject var viewModel: ProductViewModel
    
    @State private var showingAlert = false
    
    init(product: Product) {
        self.product = product
        self.viewModel = ProductViewModel(product: product)
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
                
                Spacer()
                
                Button {
                    showingAlert.toggle()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.large)
                        .foregroundStyle(.black)
                }
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text("Confirm Removal"),
                        message: Text("Do you really want to remove this item from the cart?"),
                        primaryButton: .default(Text("Yes")) {
                            Task {
                                try await viewModel.removeFromCart()
                            }
                        },
                        secondaryButton: .cancel(Text("No"))
                    )
                }
                
            }
            .font(.subheadline)
            .padding(.horizontal, 16)
            
            Divider()
        }
        .foregroundStyle(.black)
        .padding(.vertical, 8)
    }
}
