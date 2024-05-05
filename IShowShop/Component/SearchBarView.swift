//
//  SearchBarView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/5/24.
//

import SwiftUI

struct SearchBarView: View {
    @State private var text = ""
    var body: some View {
        
        HStack {
            HStack (spacing: 15){
                Image(systemName: "magnifyingglass")
                
                TextField("Enter your text here", text: $text)
                    
                
                Spacer()
                
                Image(systemName: "mic.fill")

            }
            .padding(.horizontal)
            .frame(height: 40)
            .background(Color(.systemGroupedBackground))

            
            Button {
                
            } label: {
                Image(systemName: "heart.fill")
                    .foregroundStyle(.black)
            }
            
            
            Button {
                
            } label: {
                Image(systemName: "ellipsis.message")
                    .foregroundStyle(.black)
            }
        }
        .padding(.horizontal)

        

    }
}

#Preview {
    SearchBarView()
}
