//
//  TextFieldModifier.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/6/24.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .foregroundStyle(Constant.textColor)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, 24)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.systemGray5), lineWidth: 1)
                    .padding(.horizontal, 24)
            )
            .fixedSize(horizontal: false, vertical: true)
    }
}
