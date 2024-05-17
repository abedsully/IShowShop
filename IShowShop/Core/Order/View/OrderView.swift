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

    private var subTotal: Double {
        return product.price * quantity
    }
    
    private var deliveryFee: Double {
        return subTotal > 199999 ? 0 : 15000
    }
    
    private var discountCalculation: Double {
        return discountCode == "STEFANUSALBERT" ? (subTotal * 30) / 100 : 0
    }
    
    private var discountValue: Double {
        return discountCalculation > 100000 ? 100000 : discountCalculation
    }
    
    private var valueAfterDiscount: Double {
        return subTotal - discountValue
    }
    
    init(user: User, product: Product) {
        self.viewModel = OrderViewModel(product: product, user: user)
    }
    
    private var totalStock: Double {
        return Double(product.stock) >= 9 ? 9 : Double(product.stock)
    }
    
    @State private var selectedAddress = "Please select your address"
    @State private var isDeliveryShown = false
    
    @State private var isInputDiscountCodeShown = false
    @State private var discountCode = "Enter discount code"
    
    @State private var quantity: Double = 1
    
    private var totalPrice: Double {
        return discountCode == "STEFANUSALBERT" ? (valueAfterDiscount + deliveryFee) : product.price * quantity + deliveryFee
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
                
                HStack(spacing: 5) {
                    Text("Quantity: ")
                    Stepper(value: $quantity, in: 1...totalStock) {
                        Text("\(Int(quantity))")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(Color(.systemGray2))
                    }
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
                
                VStack (alignment: .trailing){
                    
                    Text("Summary")
                        .padding(.vertical)
                    
                    HStack {
                        Text("Subtotal: ")
                        
                        Spacer()
                        
                        PriceFormatter(price: subTotal)
                    }
                    .font(.title3)
                    .padding(.bottom)
                    
                    if discountCode == "STEFANUSALBERT" {
                        HStack (alignment: .center){
                            Text("Discount: ")
                                .font(.title3)
                            
                            Spacer()
                            
                            VStack (alignment: .trailing, spacing: 8){
                                HStack {
                                    Image(systemName: "ticket")
                                        .imageScale(.medium)
                                        .foregroundStyle(Constant.mainColor)
                                    
                                    PriceFormatter(price: discountValue)
                                        .foregroundStyle(Constant.mainColor)
                                        .strikethrough()
                                }

                                
                                PriceFormatter(price: valueAfterDiscount)
                            }
                        }
                        .font(.title3)
                        .padding(.bottom)
                    }
                        

                    
                    HStack {
                        Text("Delivery Fee: ")
                            .font(.title3)
                        
                        Spacer()
                        
                        PriceFormatter(price: deliveryFee)
                    }
                    .padding(.bottom)
                    

                    
                    
                    HStack (alignment: .center){
                        Text("Total Price: ")
                            .font(.title3)
                        
                        Spacer()
                        
                        PriceFormatter(price: totalPrice)
                    }
                }
                .font(.title2)
                .padding(.vertical)
                
                
                Button {
                    Task {
                        try await viewModel.checkOutOrder(category: TransactionFilter.order.title, amount: totalPrice, address: selectedAddress, deliveryFee: deliveryFee, discount: discountValue, quantity: quantity)
                        
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
