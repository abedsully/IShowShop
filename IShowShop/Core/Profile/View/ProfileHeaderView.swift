//
//  ProfileHeaderView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/10/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @State private var showEditProfile = false
    
    private var user: User {
        return viewModel.user
    }
    
    init(user: User) {
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        HStack {
            CircularProfileImageView(user: user, size: .large)
            
            VStack (alignment: .leading, spacing: 10){
                Text(user.fullName ?? user.username)
                    .font(.headline)
                    .fontWeight(.semibold)
                Text("Joined since: 05/05/2024")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(.systemGray))
                
            }
            
            Spacer()
            
            Button {
                showEditProfile.toggle()
            } label: {
                Image(systemName: "pencil")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Constant.textColor)
            }
            .fullScreenCover(isPresented: $showEditProfile) {
                EditProfileView(user: user)
            } 
        }
        .padding(.top)
    }
}

#Preview {
    ProfileHeaderView(user: User.MOCK_USER[0])
}
