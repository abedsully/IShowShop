//
//  Timestamp.swift
//  IShowShop
//
//  Created by Stefanus Albert Wilson on 5/12/24.
//

import Foundation
import Firebase

extension Timestamp {
    func timestampString() -> String {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMM dd, yyyy HH:mm:ss"
        
        let date = self.dateValue()
        
        let formattedDate = formatter.string(from: date)

        return formattedDate
    }
}

