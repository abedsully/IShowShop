//
//  RegisterUsernameView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/6/24.
//

import SwiftUI

struct RegisterUsernameView: View {
    
    @EnvironmentObject var viewModel: RegisterViewModel
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        
        VStack (spacing: 12){
            Text("Add Your Username")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(Constant.mainColor)
            
            Text("Pick a username for your account")
                .font(.footnote)
                .foregroundStyle(.gray)
                .padding(.horizontal, 24)
            
            TextField("Enter a username", text: $viewModel.username)
                .textInputAutocapitalization(.never)
                .modifier(TextFieldModifier())
            
            NavigationLink {
                RegisterPasswordView()
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
    RegisterUsernameView()
}
