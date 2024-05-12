//
//  TransactionFilter.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/12/24.
//

import Foundation

enum TransactionFilter: Int, CaseIterable, Identifiable {
    case topUp
    case order
    
    var title: String {
        switch self {
        case .topUp:
            return "Top Up"
            
        case .order:
            return "Order"
        }
    }
    
    var id: Int? {return self.rawValue}
}
