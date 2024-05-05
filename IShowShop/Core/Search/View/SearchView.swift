//
//  SearchView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/5/24.
//

import SwiftUI

struct SearchView: View {
    @State private var text = ""
    
    
    var body: some View {
        ScrollView {
            
            SearchBarView()
            
            SearchContentListView()
        }
        .padding(.vertical)
    }
    
}

#Preview {
    SearchView()
}
