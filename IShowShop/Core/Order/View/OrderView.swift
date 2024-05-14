//
//  OrderView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/13/24.
//

import SwiftUI
import Kingfisher

struct OrderView: View {
    
    @ObservedObject var viewModel: OrderViewModel
    @Environment (\.dismiss) var dismiss
    
    private var user: User {
        return viewModel.user
    }
    
    private var product: Product {
        return viewModel.product
    }
    
    private var deliveryFee: Double {
        return product.price > 199999 ? 0 : 15000
    }
    
    private var discountCalculation: Double {
        return (product.price * 30) / 100
    }
    
    private var discountValue: Double {
        return discountCalculation > 100000 ? 100000 : discountCalculation
    }
    
    init(user: User, product: Product) {
        self.viewModel = OrderViewModel(product: product, user: user)
    }
    
    @State private var selectedAddress = "Please select your address"
    @State private var isDeliveryShown = false
    
    @State private var isInputDiscountCodeShown = false
    @State private var discountCode = "Enter available voucher"
    
    private var totalPrice: Double {
        return discountCode == "STEFANUSALBERT" ? (product.price - discountValue + deliveryFee) : product.price + deliveryFee
    }
    
    
    var body: some View {
        VStack (){
            HStack (alignment: .center, spacing: 16) {
                KFImage(URL(string: product.productImageURL))
                    .resizable()
                    .frame(width: 120, height: 120)
                    .scaledToFill()
                    .background(Color(.systemGray6))
                
                Spacer()
                
                VStack (alignment: .trailing, spacing: 5){
                    Text(product.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text(product.category)
                    
                    PriceFormatter(price: product.price)
                        .font(.title2)
                        .fontWeight(.semibold)
                }
            }
            .font(.subheadline)
            
            
            VStack (alignment: .leading, spacing: 16){
                Button {
                    isDeliveryShown.toggle()
                } label: {
                    HStack{
                        Text("Delivery Address: ") +
                        Text(selectedAddress)
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(Color(.systemGray2))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack (spacing: 5){
                    Text("Subtotal: ")
                    PriceFormatter(price: product.price)
                }
                
                HStack (spacing: 5){
                    Text("Delivery Fee: ")
                    PriceFormatter(price: deliveryFee)
                }
                
                Button {
                    isInputDiscountCodeShown.toggle()
                } label: {
                    HStack{
                        Text("Coupon Code: ") +
                        Text(discountCode)
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(Color(.systemGray2))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Spacer()
                    if discountCode == "STEFANUSALBERT" {
                        HStack (alignment: .center, spacing: 8){
                            Image(systemName: "ticket")
                                .imageScale(.medium)
                                .foregroundStyle(Constant.mainColor)
                            
                            PriceFormatter(price: product.price)
                                .foregroundStyle(Constant.mainColor)
                                .strikethrough()
                                .font(.title3)
                            PriceFormatter(price: totalPrice)
                        }
                        
                    }
                    
                    else {
                        PriceFormatter(price: totalPrice)
                    }
                }
                .font(.title2)
                .padding(.vertical)
                
                Button {
                    Task {
                        try await viewModel.checkOutOrder(category: TransactionFilter.order.title, amount: totalPrice, address: selectedAddress, deliveryFee: deliveryFee, discount: discountValue)
                        
                        try await AuthService.shared.loadUserData()
                        
                        dismiss()
                    }
                } label : {
                    Text("Checkout")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: UIScreen.main.bounds.width - 36, height: 44)
                        .background(Constant.mainColor)
                        .cornerRadius(8)
                }
            }
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundStyle(.black)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .fullScreenCover(isPresented: $isInputDiscountCodeShown, content: {
            InputDiscountCodeView(discountCode: $discountCode)
        })
        .fullScreenCover(isPresented: $isDeliveryShown, content: {
            DeliveryView(user: user, product: product, selectedAddress: $selectedAddress)
        })
        .padding(.horizontal, 24)
    }
}

#Preview {
    OrderView(user: User.MOCK_USER[0], product: Product.MOCK_PRODUCT[0])
}
