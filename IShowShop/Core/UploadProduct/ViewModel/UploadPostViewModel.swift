//
//  UploadPostViewModel.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/11/24.
//

import Foundation
import SwiftUI
import PhotosUI
import Firebase

class UploadPostViewModel: ObservableObject {
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { try await loadImage(fromItem: selectedImage) } }
    }
    
    @Published var postImage: Image?
    
    private var uiImage: UIImage?
    
    func loadImage(fromItem item: PhotosPickerItem?) async throws {
        
        // taking from the parameter item, else return
        guard let item = item else { return }
        
        // getting the data from the item (image) that we get from top
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        
        // create uiImage from UIKit, using that data we get from top
        guard let uiImage = UIImage(data: data) else { return }
        
        self.uiImage = uiImage
        
        // create SwiftUI using that uiImage
        self.postImage = Image(uiImage: uiImage)
    }
    
    func uploadProduct(name: String, description: String, price: String, category: String, stock: String) async throws {
        guard let uiImage = uiImage else {return}
        
        guard let imageURL = try await ImageUploader.uploadImage(image: uiImage) else {return}
        
        let productRef = Constant.productCollection.document(category).collection("product-list").document()
        
        let price = Double(price) ?? 0.0
        let stock = Int(stock) ?? 0
        
        let product = Product(id: productRef.documentID, name: name, price: price, description: description, productImageURL: imageURL, category: category, stock: stock, sold: 0)
        
        guard let encodedPost = try? Firestore.Encoder().encode(product) else {return}
        
        try await productRef.setData(encodedPost)
    }
    
}
