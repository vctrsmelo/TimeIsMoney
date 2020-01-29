//
//  Flow.swift
//  TimeIsMoneyEngine
//
//  Created by Victor Melo on 11/11/19.
//  Copyright © 2019 Victor Melo. All rights reserved.
//

import Foundation

let WEEKS_IN_MONTH = 4.429531 // ~30 days per month
let SECONDS_IN_HOUR = 3600.00

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
    
    public func getTimeNeededToPay(for price: Double) -> Result<WorkTimeSeconds, CalculatorError> {
        return Calculator.getWorkTimeToPay(for: price, user: user)
    }

    /// Used to set image
    public func getExpensivityIndex(price: Double, maxIndex: Int) -> Int {
        let maxPrice = max(1,user.monthlySalary)
        let normalizedIndex = Int(round(price * Double(maxIndex) / maxPrice.asDouble()))
        let expensivityIndex = min(normalizedIndex, maxIndex)
        
        return expensivityIndex
    }
}
