//
//  RegisterEmailView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/6/24.
//

import SwiftUI

struct RegisterEmailView: View {
    @EnvironmentObject var viewModel: RegisterViewModel
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        VStack (spacing: 12){
            Text("Add Your Email")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Constant.mainColor)
            
            Text("You will use this email to sign in to your account")
                .font(.footnote)
                .foregroundStyle(.gray)
                .padding(.horizontal, 24)
            
            TextField("Enter your email", text: $viewModel.email)
                .textInputAutocapitalization(.never)
                .modifier(TextFieldModifier())
                .padding(.top)
            
            NavigationLink {
                RegisterUsernameView()
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
            .padding(.top)
            
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
    RegisterEmailView()
}
