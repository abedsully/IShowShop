//
//  DeliveryView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/13/24.
//

import SwiftUI

struct DeliveryView: View {
    @Environment (\.dismiss) var dismiss
    
    @ObservedObject var viewModel: OrderViewModel
    
    private var user: User {
        return viewModel.user
    }
    
    private var product: Product {
        return viewModel.product
    }
    
    @Binding var selectedAddress: String
    
    init(user: User, product: Product, selectedAddress: Binding<String>) {
        self.viewModel = OrderViewModel(product: product, user: user)
        _selectedAddress = selectedAddress
    }
    
    @State private var showDeliveryInput = false

    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 15){
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .padding(.horizontal, 12)
            }
            .foregroundStyle(Constant.textColor)

            
            ScrollView {
                VStack (alignment: .leading, spacing: 15){
                    Text("Delivery Address")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Button {
                        showDeliveryInput.toggle()
                    } label: {
                        Text("+ Add New Address")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
                .padding(.horizontal, 36)
                
                
                
                ForEach(viewModel.addressList, id: \.self) { address in
                    VStack (alignment: .leading) {
                        Text(address.address)
                            .onTapGesture {
                                selectedAddress = address.address
                                dismiss()
                            }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal, 36)
                    
                    
                    Divider()
                }

            }
            .refreshable {
                Task {
                    try await viewModel.fetchAddressList()
                }
            }
        }
        .onAppear {
            Task {
                try await viewModel.fetchAddressList()
            }
        }
        .fullScreenCover(isPresented: $showDeliveryInput, content: {
            InputDeliveryView(user: user, product: product)
        })
    }
}
