//
//  PriceFormatter.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/10/24.
//

import SwiftUI

struct PriceFormatter: View {
    let price: Double
    
    var body: some View {
        Text(formatPrice())
    }
    
    private func formatPrice() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "IDR"
        formatter.maximumFractionDigits = 1
        
        if let formattedPrice = formatter.string(from: NSNumber(value: price)) {
            return formattedPrice
        } else {
            return "Error formatting price."
        }
    }
}

#Preview {
    PriceFormatter(price: 100000)
}
