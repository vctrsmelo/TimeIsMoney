//
//  General Extensions.swift
//  Time is Money
//
//  Created by Victor Melo on 04/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation

extension Bool {
    mutating func negate() {
        self = !self
    }
}

extension Decimal {
    func asDouble() -> Double {
        return (self as NSDecimalNumber).doubleValue
    }
    
    func asNSNumber() -> NSNumber {
        return (self as NSDecimalNumber)
    }
}
