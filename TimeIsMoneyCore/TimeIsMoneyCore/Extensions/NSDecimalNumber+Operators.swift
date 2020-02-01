//
//  NSDecimalNumber+Operators.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 31/01/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation

// MARK: - Comparable
extension NSDecimalNumber: Comparable {}

public func ==(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
    return lhs.compare(rhs) == .orderedSame
}

public func <(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
    return lhs.compare(rhs) == .orderedAscending
}

// MARK: - Arithmetic Operators
public prefix func -(value: NSDecimalNumber) -> NSDecimalNumber {
    return value.multiplying(by: NSDecimalNumber(mantissa: 1, exponent: 0, isNegative: true))
}

public func +(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.adding(rhs)
}

public func -(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.subtracting(rhs)
}

public func *(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.multiplying(by: rhs)
}

public func /(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.dividing(by: rhs)
}

public func ^(lhs: NSDecimalNumber, rhs: Int) -> NSDecimalNumber {
    return lhs.raising(toPower: rhs)
}

public func %(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    let dividend = lhs
    let divisor = rhs
    let quotient: NSDecimalNumber? = dividend.dividing(by: divisor, withBehavior: NSDecimalNumberHandler(roundingMode: .down, scale: 0, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false))
    let subtractAmount: NSDecimalNumber? = quotient?.multiplying(by: divisor)
    var remainder: NSDecimalNumber? = nil
    if let anAmount = subtractAmount {
        remainder = dividend.subtracting(anAmount)
    }
    
    return remainder ?? NSDecimalNumber(value: 0.0)
}

extension Double {
    func asMoney() -> Money {
        return Money(value: self)
    }
}

extension Int {
    func asMoney() -> Money {
        return Money(value: self)
    }
}

extension Decimal {
    func asMoney() -> Money {
        return Money(decimal: self)
    }
}

extension NSDecimalNumber {
    
    var timeIntervalValue: TimeInterval {
        return self.doubleValue
    }
    
    var floor: NSDecimalNumber {
        let handler = NSDecimalNumberHandler(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 0, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return self.rounding(accordingToBehavior: handler)
    }
    
    var round: NSDecimalNumber {
        let handler = NSDecimalNumberHandler(roundingMode: NSDecimalNumber.RoundingMode.bankers, scale: 0, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return self.rounding(accordingToBehavior: handler)
    }
    
    var ceil: NSDecimalNumber {
        let handler = NSDecimalNumberHandler(roundingMode: NSDecimalNumber.RoundingMode.up, scale: 0, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return self.rounding(accordingToBehavior: handler)
    }

}
