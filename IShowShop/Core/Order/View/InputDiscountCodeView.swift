//
//  InputDiscountCodeView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/15/24.
//

import SwiftUI

struct InputDiscountCodeView: View {
    
    @Environment (\.dismiss) var dismiss
    @State private var couponCodeInputValue = ""
    @Binding var discountCode: String
    
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
            .foregroundStyle(.black)
            
            Spacer()
            
            Text("Enter Coupon Code")
                .padding(.horizontal, 24)
            
            TextField("", text: $couponCodeInputValue, axis: .vertical)
                .modifier(TextFieldModifier())
                .autocapitalization(.allCharacters)
            
            Button {
                discountCode = couponCodeInputValue
                dismiss()
            } label : {
                Text("Use Discount Code")
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
    }
}

//#Preview {
//    InputDiscountCodeView()
//}
