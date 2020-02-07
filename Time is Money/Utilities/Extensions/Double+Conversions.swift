//
//  Double+Conversions.swift
//  Time is Money
//
//  Created by Victor Melo on 07/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

public extension Double {
    func asDecimal() -> Decimal {
        Decimal(self)
    }
    
    func asNSDecimalNumber() -> NSDecimalNumber {
        NSDecimalNumber(value: self)
    }
}
