//
//  EditProfileViewModel.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/10/24.
//

import PhotosUI
import Firebase
import SwiftUI

@MainActor
class EditProfileViewModel: ObservableObject {
    
    @Published var user: User
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { try await loadImage(fromItem: selectedImage) } }
    }
    
    @Published var profileImage: Image?
    @Published var fullname = ""
    @Published var bio = ""
    
    private var uiImage: UIImage?
    
    init(user: User){
        self.user = user
        
        if let fullname = user.fullName {
            self.fullname = fullname
        }
    }
    
    func loadImage(fromItem item: PhotosPickerItem?) async throws {
        
        // taking from the parameter item, else return
        guard let item = item else { return }
        
        // getting the data from the item (image) that we get from top
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        
        // create uiImage from UIKit, using that data we get from top
        guard let uiImage = UIImage(data: data) else { return }
        
        self.uiImage = uiImage
        
        // create SwiftUI using that uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    func updateUserData() async throws {
        // Update Profile Image
        var data = [String: Any]()
        
        if let uiImage = uiImage{
            let imageURL = try? await ImageUploader.uploadImage(image: uiImage)
            data["profileImageURL"] = imageURL
        }
        
        // Update Name
        if !fullname.isEmpty && user.fullName != fullname {
            user.fullName = fullname
            data["fullName"] = fullname
        }
        
        
        if !data.isEmpty {
            try await Constant.userCollection.document(user.id).updateData(data)
        }
    }
}
