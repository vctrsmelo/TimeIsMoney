//
//  User+Operations.swift
//  Time is Money
//
//  Created by Victor Melo on 07/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation


extension User {
    
    func getSalaryPerYear() -> Money {
        monthlySalary * NSDecimalNumber(value: 12)
    }

    func getSalaryPerMonth() -> Money {
        monthlySalary
    }

    func getSalaryPerWeek() -> Money {
        getSalaryPerMonth() / MonthTimePeriod(value: 1).asWeekOfMonth()
    }

    func getSalaryPerDay() -> Money {
        guard weeklyWorkDays > 0 else { return Money(value: 0) }
        return getSalaryPerWeek() / weeklyWorkDays
    }

    func getSalaryPerHour() -> Money {
        guard dailyWorkHours > 0 else { return Money(value: 0) }
        return getSalaryPerDay() / dailyWorkHours
    }

    func getSalaryPerMinute() -> Money {
        getSalaryPerHour() / NSDecimalNumber(value: 60)
    }

    func getSalaryPerSecond() -> Money {
        getSalaryPerMinute() / NSDecimalNumber(value: 1.minuteInSeconds)
    }

    func getMoneyReceivedFromSeconds(workSeconds: TimeInterval) -> Money {
        return getSalaryPerSecond() * NSDecimalNumber(value: workSeconds)
    }
}
