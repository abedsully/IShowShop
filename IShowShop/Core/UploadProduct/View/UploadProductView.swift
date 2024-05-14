//
//  UploadProductView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/11/24.
//

import SwiftUI

struct UploadProductView: View {
    @State private var productName = ""
    @State private var productDescription = ""
    @State private var productCategory: CategoryFilter = .clothes
    @State private var productPrice = ""
    @State private var productStock = ""
    
    @State private var imagePickerPresented = false
    @ObservedObject var viewModel: UploadPostViewModel
    @Binding var tabIndex: Int
    
    private var user: User {
        return viewModel.user
    }
    
    init(tabIndex: Binding<Int>, user: User) {
        _tabIndex = tabIndex
        self.viewModel = UploadPostViewModel(user: user)
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    clearProductDataAndReturn()
                } label: {
                    Image(systemName: "multiply")
                        .imageScale(.large)
                    
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("New Product")
                        .fontWeight(.semibold)
                }
                .padding(.leading, 15)
                
                Spacer()
                
                Button {
                    Task {
                        try await viewModel.uploadProduct(name: productName, description: productDescription, price: productPrice, category: productCategory.title, stock: productStock, user: user)
                        
                        clearProductDataAndReturn()
                    }
                } label: {
                    Text("Save")
                        .fontWeight(.semibold)
                }
            }
            .foregroundStyle(.black)
            .padding(.horizontal)
            
            ScrollView {
                VStack (spacing: 20){
                    if let image = viewModel.postImage {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 250)
                            .clipped()
                            .padding(.vertical, 12)
                    }
                    
                    VStack (alignment: .leading){
                        Text("Product Name")
                            .foregroundStyle(.black)
                            .padding(.horizontal, 25)
                        TextField("Enter Product Name", text: $productName, axis: .vertical)
                            .modifier(TextFieldModifier())
                            .textInputAutocapitalization(.never)
                    }
                    
                    HStack (){
                        Text("Product Category")
                            .foregroundStyle(.black)
                        
                        Spacer()
                        
                        Picker("Category", selection: $productCategory) {
                            ForEach(CategoryFilter.allCases, id: \.self) { category in
                                Text(category.title)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding(.horizontal, 12)
                    }
                    .modifier(TextFieldModifier())
                    
                    VStack (alignment: .leading){
                        Text("Product Description")
                            .foregroundStyle(.black)
                            .padding(.horizontal, 25)
                        TextField("Enter Product Description", text: $productDescription, axis: .vertical)
                            .modifier(TextFieldModifier())
                            .textInputAutocapitalization(.never)
                    }
                    
                    VStack (alignment: .leading){
                        Text("Product Price")
                            .foregroundStyle(.black)
                            .padding(.horizontal, 25)
                        TextField("Enter Product Price", text: $productPrice, axis: .vertical)
                            .modifier(TextFieldModifier())
                            .textInputAutocapitalization(.never)
                    }
                    
                    VStack (alignment: .leading){
                        Text("Product Stock")
                            .foregroundStyle(.black)
                            .padding(.horizontal, 25)
                        TextField("Enter Product Stock", text: $productStock, axis: .vertical)
                            .modifier(TextFieldModifier())
                            .textInputAutocapitalization(.never)
                    }
                }
                
            }
            .onAppear {
                imagePickerPresented.toggle()
            }
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
    }
    
    func clearProductDataAndReturn (){
        productName = ""
        productCategory = .clothes
        productDescription = ""
        productPrice = ""
        productStock = ""
        viewModel.selectedImage = nil
        viewModel.postImage = nil
        tabIndex = 0
    }
}

#Preview {
    UploadProductView(tabIndex: .constant(0), user: User.MOCK_USER[0])
}

