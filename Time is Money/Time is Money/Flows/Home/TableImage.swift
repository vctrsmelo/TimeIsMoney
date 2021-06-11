//
//  TableImage.swift
//  Time is Money
//
//  Created by Victor Melo on 07/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation

enum TableImage {
    
    static let maxIndex: NSDecimalNumber = 13
    
    /// Used to set image
    static func getImageIndex(price: NSDecimalNumber, user: User) -> Int {
        let maxPrice = max(1,user.monthlySalary)
        let normalizedIndex = round((price * maxIndex / maxPrice).doubleValue)
        let expensivityIndex = min(normalizedIndex, maxIndex.doubleValue)

        return Int(expensivityIndex)
    }
}
