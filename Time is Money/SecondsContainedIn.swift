//
//  SecondsContainedIn.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 29/01/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation

enum SecondsContainedIn: Int {
    case year = 31104000
    case month = 2592000
    case week = 604800
    case day = 86400
    case hour = 3600
    case minute = 60
    
    func asDouble() -> Double {
        return Double(self.rawValue)
    }
    
    func asNSDecimalNumber() -> NSDecimalNumber {
        return NSDecimalNumber(value: self.rawValue)
    }
}
