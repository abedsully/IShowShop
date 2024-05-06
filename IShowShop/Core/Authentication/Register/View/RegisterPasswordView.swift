//
//  RegisterPasswordView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/6/24.
//

import SwiftUI

struct RegisterPasswordView: View {
    
    @State private var password = ""
    @Environment (\.dismiss) var dismiss
    
    
    var body: some View {
        VStack (spacing: 12){
            Text("Set your password")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(Constant.mainColor)
            
            Text("Please enter a password for at least 8 characters")
                .font(.footnote)
                .foregroundStyle(.gray)
                .padding(.horizontal, 24)
            
            SecureField("Enter your password", text: $password)
                .textInputAutocapitalization(.never)
                .modifier(TextFieldModifier())
            
            NavigationLink {
                Text("Complete sign up view")
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
     
