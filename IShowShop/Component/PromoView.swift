//
//  PromoView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/5/24.
//

import SwiftUI

struct PromoView: View {
    var body: some View {
        Image("ads")
            .resizable()
            .scaledToFit()
            .frame(width: UIScreen.main.bounds.width - 20, height: 200)
    }
}

#Preview {
    PromoView()
}
