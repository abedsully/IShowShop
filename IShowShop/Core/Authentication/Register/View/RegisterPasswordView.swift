//
//  RegisterPasswordView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/6/24.
//

import SwiftUI

struct RegisterPasswordView: View {
    
    @EnvironmentObject var viewModel: RegisterViewModel
    
    @Environment (\.dismiss) var dismiss
    
    
    var body: some View {
        VStack (spacing: 12){
            Text("Set your password")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(Constant.mainColor)
            
            Text("Please enter a password for at least 8 characters")
                .font(.footnote)
                .foregroundStyle(.gray)
                .padding(.horizontal, 24)
            
            SecureField("Enter your password", text: $viewModel.password)
                .textInputAutocapitalization(.never)
                .modifier(TextFieldModifier())
            
            NavigationLink {
                CompleteSignUpView()
                    .navigationBarBackButtonHidden()
            } label: {
                Text("Next")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 350, height: 44)
                    .background(Constant.mainColor)
                    .cornerRadius(8)
            }
            .padding(.vertical)
            
            Spacer()

        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
    }
}

#Preview {
    RegisterPasswordView()
}
     
