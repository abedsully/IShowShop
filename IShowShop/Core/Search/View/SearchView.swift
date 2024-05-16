//
//  SearchView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/5/24.
//

import SwiftUI

struct SearchView: View {
    let user: User
    @State private var text = ""
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                SearchBarView(user: user)
                
                SearchContentListView()
            }
            .padding(.vertical)
        }
    }
    
}

#Preview {
    SearchView(user: User.MOCK_USER[0])
}
