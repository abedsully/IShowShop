//
//  TransactionDetailView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/13/24.
//

import SwiftUI
import Kingfisher

struct TransactionDetailView: View {
    
    let transaction: Transaction
    let user: User
    
    @StateObject var viewModel = NotificationViewModel()
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        
        ScrollView {
            VStack {
                if transaction.transactionCategory == TransactionFilter.order.title {
                    
                    VStack (alignment: .leading) {
                        
                        VStack {
                            KFImage(URL(string: transaction.product?.productImageURL ?? ""))
                                .resizable()
                                .frame(width: 160, height: 160)
                                .scaledToFill()
                                .padding(.bottom)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                        
                        VStack (alignment: .leading){
                            Text("Order Id: ").fontWeight(.semibold) + Text(transaction.id)
                            Text("Product Name: ").fontWeight(.semibold) + Text(transaction.product?.name ?? "")
                            Text("Product Category: ").fontWeight(.semibold) + Text(transaction.product?.category ?? "")
                        }
                        .font(.title3)
                        
                        Divider()
                        
                        VStack (alignment: .leading) {
                            HStack {
                                Text("Ordered at: ")
                                    .fontWeight(.semibold)
                                Text(transaction.timestamp.timestampString())
                            }
                            
                            if transaction.status == true {
                                HStack {
                                    Text("Delivered at: ")
                                        .fontWeight(.semibold)
                                    Text(transaction.deliveryCompleteDate?.timestampString() ?? "")
                                }
                            }
                        }
                        .font(.title3)
                        
                        Divider()
                        
                        VStack (alignment: .leading){
                            Text("Delivery Details: ").fontWeight(.semibold) + Text(transaction.deliveryAddress ?? "")
                        }
                        .font(.title3)
                        
                        Divider()
                        
                        VStack (alignment: .leading){
                            Text("Order Status")
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            if let status = transaction.status {
                                HStack (spacing: 8){
                                    Text(status ? "Completed" : "Received")
                                    Image(systemName: status ? "checkmark.circle.fill" : "arrow.down.circle.fill")
                                        .foregroundStyle(status ? .green : .gray)
                                }
                                
                            }
                        }
                        
                        Divider()
                        
                        VStack (alignment: .trailing){
                            
                            Text("Summary")
                                .padding(.vertical)
                            
                            HStack {
                                Text("Subtotal: ")
                                
                                Spacer()
                                
                                PriceFormatter(price: (transaction.product?.price ?? 0) * (transaction.quantity ?? 0))
                            }
                            .font(.title3)
                            .padding(.bottom)
                            
                            HStack {
                                Text("Quantity: ")
                                
                                Spacer()
                                
                                Text("\(Int(transaction.quantity ?? 0))")
                            }
                            .font(.title3)
                            .padding(.bottom)
                            
                            if transaction.discount ?? 0 != 0 {
                                HStack (alignment: .center){
                                    Text("Discount: ")
                                        .font(.title3)
                                    
                                    Spacer()
                                    
                                    VStack (alignment: .trailing, spacing: 8){
                                        HStack {
                                            Image(systemName: "ticket")
                                                .imageScale(.medium)
                                                .foregroundStyle(Constant.mainColor)
                                            
                                            PriceFormatter(price: transaction.discount ?? 0)
                                                .foregroundStyle(Constant.mainColor)
                                                .strikethrough()
                                        }
                                    }
                                }
                                .font(.title3)
                                .padding(.bottom)
                            }


                            HStack {
                                Text("Delivery Fee: ")
                                    .font(.title3)
                                
                                Spacer()
                                
                                PriceFormatter(price: transaction.deliveryFee ?? 0)
                            }
                            .padding(.bottom)
                            

                            HStack (alignment: .center){
                                Text("Total Price: ")
                                    .font(.title3)
                                
                                Spacer()
                                
                                PriceFormatter(price: transaction.amount)
                            }
                        }
                        .fontWeight(.semibold)
                        .font(.title2)
                        .padding(.vertical)
                        
                        if user.isSuper && transaction.status == false {
                            Button {
                                Task {
                                    try await viewModel.completeOrder(buyerId: transaction.userId, transactionId: transaction.id)
                                    dismiss()
                                }
                            } label : {
                                Text("Complete Order")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .frame(width: UIScreen.main.bounds.width - 24, height: 44)
                                    .background(Constant.mainColor)
                                    .cornerRadius(8)
                            }
                            .padding(.vertical)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                    
                    
                    Spacer()
                    
                    
                } else {
                    HStack (spacing: 10){
                        Image("logo")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .scaledToFill()
                        
                        VStack (alignment: .leading){
                            Text("Top Up")
                            
                            PriceFormatter(price: transaction.amount)
                                .fontWeight(.semibold)
                        }
                        .font(.title3)
                    }
                    .padding(.top, 36)
                    
                    
                    HStack {
                        Text("Topup at: ")
                            .fontWeight(.semibold)
                        Text(transaction.timestamp.timestampString())
                    }
                    .font(.title3)
                    
                    
                    Spacer()
                    
                }
            }
            .scrollIndicators(.hidden)
        }
        
    }
    
}

#Preview {
    TransactionDetailView(transaction: Transaction.MOCK_TRANSACTION[0], user: User.MOCK_USER[0])
}
