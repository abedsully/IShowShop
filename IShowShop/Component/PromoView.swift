//
//  PromoView.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/15/24.
//

import SwiftUI

struct PromoView: View {
    @State private var currentAdIndex = 0
    private let ads = ["ads", "ads-2"]
    private let displayDuration: TimeInterval = 15.0
    
    var body: some View {
        Image(ads[currentAdIndex])
            .resizable()
            .scaledToFit()
            .frame(width: UIScreen.main.bounds.width - 20, height: 200)
            .onAppear {
                startAdCycle()
            }
    }
    
    private func startAdCycle() {
        Timer.scheduledTimer(withTimeInterval: displayDuration, repeats: true) { timer in
            currentAdIndex = (currentAdIndex + 1) % ads.count
        }
    }
}

#Preview {
    PromoView()
}

