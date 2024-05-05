//
//  CategoryFilter.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/5/24.
//

import Foundation

enum CategoryFilter: Int, CaseIterable, Identifiable {
    case clothes
    case shoes
    case electronics
    case essentials
    case others
    
    var title: String {
        switch self {
        case .clothes:
            return "Clothes"
        case .shoes:
            return "Shoes"
        case .electronics:
            return "Electronics"
        case .essentials:
            return "Essentials"
        case .others:
            return "Others"
        }
    }
    
    var id: Int? {return self.rawValue}
}
