//
//  LoginView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/6/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        
        NavigationStack {
            VStack (spacing: 10){
                Spacer()
                
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFill()
                
                VStack (spacing: 15){
                    TextField("Enter your email", text: $email)
                        .textInputAutocapitalization(.never)
                        .modifier(TextFieldModifier())
                    
                    SecureField("Enter your password", text: $password)
                        .modifier(TextFieldModifier())
                }

                
                Button {
                    
                } label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 350, height: 44)
                        .background(Constant.mainColor)
                        .cornerRadius(8)
                }
                .padding(.vertical)
                
                Spacer()
                
                Divider()
                
                NavigationLink {
                    Text("Register View")
                } label: {
                    HStack {
                        Text("Don't have an account?")
                            .foregroundStyle(.black)
                        
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
