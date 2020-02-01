//
//  Flow.swift
//  TimeIsMoneyEngine
//
//  Created by Victor Melo on 11/11/19.
//  Copyright © 2019 Victor Melo. All rights reserved.
//

import Foundation

let WEEKS_IN_MONTH = NSDecimalNumber(value: 4.429531) // ~30 days per month
let SECONDS_IN_HOUR = NSDecimalNumber(value: 3600.00)

public typealias WorkTimeSeconds = TimeInterval

public enum CalculatorError: Error {
    case undefinedWeeklyWorkDays
    case undefinedWeeklyWorkHours
    case undefinedSalary
}

public class Flow {

    public let user: User
    
    public init(user: User = User.instance) {
        self.user = user
    }
    
    public func getTimeNeededToPay(for moneyDouble: Double) -> Result<WorkTimeSeconds, CalculatorError> {
        return Calculator.getWorkTimeToPay(for: Money(value: moneyDouble), user: user)
    }
    
    public func getTimeNeededToPay(for money: Money) -> Result<WorkTimeSeconds, CalculatorError> {
        return Calculator.getWorkTimeToPay(for: money, user: user)
    }

    /// Used to set image
    public func getExpensivityIndex(price: NSDecimalNumber, maxIndex: NSDecimalNumber) -> Int {
        let maxPrice = NSDecimalNumber(value: max(1,user.monthlySalary).asDouble())
        let normalizedIndex = round((price * maxIndex / maxPrice).doubleValue)
        let expensivityIndex = min(normalizedIndex, maxIndex.doubleValue)
        
        return Int(expensivityIndex)
    }
}
