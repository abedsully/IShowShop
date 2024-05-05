//
//  CircularProfileImageView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/5/24.
//

import SwiftUI

enum ProfileImageSize {
    case xSmall
    case small
    case medium
    case large
    
    var dimension: CGFloat {
        switch self {
        case .xSmall:
            return 36
        case .small:
            return 48
        case .medium:
            return 64
        case .large:
            return 88
        }
    }
}

struct CircularProfileImageView: View {
    let size: ProfileImageSize
    
    var body: some View {
        Image("sample_profile")
            .resizable()
            .scaledToFill()
            .frame(width: size.dimension, height: size.dimension)
            .clipShape(Circle())
    }
}
