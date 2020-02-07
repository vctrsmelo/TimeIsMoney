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
        NSDecimalNumber(decimal: monthlySalary) * NSDecimalNumber(value: 12)
    }

    func getSalaryPerMonth() -> Money {
        NSDecimalNumber(decimal: monthlySalary)
    }

    func getSalaryPerWeek() -> Money {
        getSalaryPerMonth() / MonthTimePeriod(value: 1).asWeekOfMonth()
    }

    func getSalaryPerDay() -> Money {
        getSalaryPerWeek() / weeklyWorkDays
    }

    func getSalaryPerHour() -> Money {
        getSalaryPerDay() / dailyWorkHours
    }

    func getSalaryPerMinute() -> Money {
        getSalaryPerHour() / NSDecimalNumber(value: 60)
    }

    func getSalaryPerSecond() -> Money {
        getSalaryPerMinute() / NSDecimalNumber(value: SecondsContainedIn.minute.rawValue)
    }

    func getMoneyReceivedFromSeconds(workSeconds: TimeInterval) -> Money {
        return getSalaryPerSecond() * NSDecimalNumber(value: workSeconds)
    }
}
