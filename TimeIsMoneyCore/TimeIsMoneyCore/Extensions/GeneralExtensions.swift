//
//  GeneralExtensions.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 07/01/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
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

public extension Double {
    func asDecimal() -> Decimal {
        Decimal(self)
    }
}
