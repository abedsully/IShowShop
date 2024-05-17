//
//  LoginView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/6/24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        
        NavigationStack {
            VStack (spacing: 10){
                Spacer()
                
                Image("logo")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .scaledToFill()
                
                VStack (spacing: 15){
                    TextField("Enter your email", text: $viewModel.email)
                        .textInputAutocapitalization(.never)
                        .modifier(TextFieldModifier())
                    
                    SecureField("Enter your password", text: $viewModel.password)
                        .modifier(TextFieldModifier())
                }

                
                Button {
                    Task {
                        try await viewModel.login()
                    }
                } label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 380, height: 44)
                        .background(Constant.mainColor)
                        .cornerRadius(8)
                }
                .padding(.vertical)
                
                Spacer()
                
                Divider()
                
                NavigationLink {
                    RegisterEmailView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack {
                        Text("Don't have an account?")
                            .foregroundStyle(Constant.textColor)
                        
                        Text("Register Now")
                            .foregroundStyle(Constant.mainColor)
                            .fontWeight(.semibold)
                    }
                }
                .padding(.vertical)
                .font(.footnote)

            }
        }

    }
}

#Preview {
    LoginView()
}
