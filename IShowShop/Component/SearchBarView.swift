//
//  SearchBarView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/5/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var inputProducts: String
    @State private var showFavoriteProduct = false
    @StateObject var viewmodel = SearchViewModel()
    
    
    var body: some View {

        HStack {
            HStack (spacing: 15){
                Image(systemName: "magnifyingglass")
                
                TextField("Search products here", text: $inputProducts)
                
                Spacer()
                
                Image(systemName: "mic.fill")

            }
            .padding(.horizontal)
            .frame(height: 40)
            .background(Color(.systemGroupedBackground))

            Button {
                showFavoriteProduct.toggle()
            } label: {
                Image(systemName: "heart.fill")
                    .foregroundStyle(.black)
            }
            .fullScreenCover(isPresented: $showFavoriteProduct, content: {
                FavoriteProductView()
            })
            
            Button {
                
            } label: {
                Image(systemName: "ellipsis.message")
                    .foregroundStyle(.black)
            }
        }
        .padding(.bottom)
        .padding(.trailing, 10)

        

    }
}

#Preview {
    SearchBarView(inputProducts: .constant(""))
}
