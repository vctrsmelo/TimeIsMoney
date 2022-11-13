//
//  User+Operations.swift
//  Time is Money
//
//  Created by Victor Melo on 07/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation


extension User {
    
    func getSalaryPerYear() -> Currency {
        monthlySalary * NSDecimalNumber(value: 12)
    }

    func getSalaryPerMonth() -> Currency {
        monthlySalary
    }

    func getSalaryPerWeek() -> Currency {
        getSalaryPerMonth() / MonthTimePeriod(value: 1).asWeekOfMonth()
    }

    func getSalaryPerDay() -> Currency {
        guard weeklyWorkDays > 0 else { return Currency(value: 0) }
        return getSalaryPerWeek() / weeklyWorkDays
    }

    func getSalaryPerHour() -> Currency {
        guard dailyWorkHours > 0 else { return Currency(value: 0) }
        return getSalaryPerDay() / dailyWorkHours
    }

    func getSalaryPerMinute() -> Currency {
        getSalaryPerHour() / NSDecimalNumber(value: 60)
    }

    func getSalaryPerSecond() -> Currency {
        getSalaryPerMinute() / NSDecimalNumber(value: 1.minuteInSeconds)
    }

    func getCurrencyReceivedFromSeconds(workSeconds: TimeInterval) -> Currency {
        return getSalaryPerSecond() * NSDecimalNumber(value: workSeconds)
    }
}
