//
//  Decimal+Conversions.swift
//  Time is Money
//
//  Created by Victor Melo on 07/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation

public extension Decimal {
    func asDouble() -> Double {
        return (self as NSDecimalNumber).doubleValue
    }
    
    func asNSNumber() -> NSNumber {
        return (self as NSDecimalNumber)
    }
}
