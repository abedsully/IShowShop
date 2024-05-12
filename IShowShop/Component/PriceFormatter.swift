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
        formatter.maximumFractionDigits = 0

        if let formattedPrice = formatter.string(from: NSNumber(value: price)) {
            let modifiedPrice = formattedPrice
                .replacingOccurrences(of: "IDR", with: "Rp")
                .replacingOccurrences(of: ",", with: ".")
            return modifiedPrice
        } else {
            return "Error formatting price."
        }
    }

}

#Preview {
    PriceFormatter(price: 100000)
}
