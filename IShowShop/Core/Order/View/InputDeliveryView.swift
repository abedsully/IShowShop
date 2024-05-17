//
//  InputDeliveryView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/13/24.
//

import SwiftUI

struct InputDeliveryView: View {
    @State private var address = ""
    @Environment (\.dismiss) var dismiss
    
    @ObservedObject var viewModel: OrderViewModel
    
    private var user: User {
        return viewModel.user
    }
    
    private var product: Product {
        return viewModel.product
    }
    
    init(user: User, product: Product) {
        self.viewModel = OrderViewModel(product: product, user: user)
    }
    
    var body: some View {
        VStack (alignment: .leading){
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
            }
            .foregroundStyle(Constant.textColor)
            
            Spacer()
            
            Text("Add New Address")
                .padding(.horizontal, 24)
            
            TextField("Enter address", text: $address, axis: .vertical)
                .modifier(TextFieldModifier())
                .textInputAutocapitalization(.never)
                .foregroundStyle(Constant.textColor)
            
            Button {
                Task {
                    try await viewModel.addDeliveryAddress(address: address)
                    dismiss()
                    try await viewModel.fetchAddressList()
                    address = ""
                }
            } label : {
                Text("Save Address")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width - 48, height: 44)
                    .background(Constant.mainColor)
                    .cornerRadius(8)
            }
            .padding(24)
            
            Spacer()
            
        }
        .foregroundStyle(Constant.textColor)

        

    }
}

#Preview {
    InputDeliveryView(user: User.MOCK_USER[0], product: Product.MOCK_PRODUCT[0])
}
