//
//  EditProfileView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/10/24.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment (\.dismiss) var dismiss
 
    @StateObject var viewModel: EditProfileViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            // toolbar
            VStack {
                HStack {
                    Button("Cancel") {
                        dismiss()
                    }
                    
                    Spacer()
                    
                    Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button {
                        Task {
                            try await viewModel.updateUserData()
                            dismiss()
                            try await AuthService.shared.loadUserData()
                        }
                        
                    } label: {
                        Text("Done")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                }
                .padding(.horizontal)
                
                Divider()
            }
            
            // Edit Profile Picture
            PhotosPicker(selection: $viewModel.selectedImage) {
                VStack {
                    if let image = viewModel.profileImage {
                        image
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                            .background(.gray)
                            .clipShape(Circle())
                    } else {
                        CircularProfileImageView(user: viewModel.user, size: .large)
                    }
                    
                    Text("Edit Profile Picture")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Divider()
                }
            }
            .padding(.vertical, 8)
            
            
            // Edit Profile Info
            VStack {
                EditProfileRowView(title: "Name", placeholder: "Enter your full name", text: $viewModel.fullname)
            }
            
            
            Spacer()
        }
    }
}

struct EditProfileRowView: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Text(title)
                .padding(.leading, 9)
                .frame(width: 100, alignment: .leading)
            
            VStack {
                TextField(placeholder, text: $text)
                    .autocorrectionDisabled(true)
                
                Divider()
            }
        }
        .font(.subheadline)
        .frame(height: 36)
    }
}

#Preview {
    EditProfileView(user: User.MOCK_USER[0])
}
