//
//  User+Operations.swift
//  Time is Money
//
//  Created by Victor Melo on 07/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation


extension AppState.User {
    
    var weeklyWorkDays: NSDecimalNumber {
        NSDecimalNumber(value: workdays.count)
    }
    
    var dailyWorkHours: NSDecimalNumber {
        NSDecimalNumber(value: weeklyWorkHours) / weeklyWorkDays
    }
    
    public func getSalaryPerYear() -> Money {
        NSDecimalNumber(decimal: monthlySalary) * NSDecimalNumber(value: 12)
    }

    public func getSalaryPerMonth() -> Money {
        NSDecimalNumber(decimal: monthlySalary)
    }

    public func getSalaryPerWeek() -> Money {
        getSalaryPerMonth() / MonthTimePeriod(value: 1).asWeekOfMonth()
    }

    public func getSalaryPerDay() -> Money {
        getSalaryPerWeek() / weeklyWorkDays
    }

    public func getSalaryPerHour() -> Money {
        getSalaryPerDay() / dailyWorkHours
    }

    public func getSalaryPerMinute() -> Money {
        getSalaryPerHour() / NSDecimalNumber(value: 60)
    }

    public func getSalaryPerSecond() -> Money {
        getSalaryPerMinute() / NSDecimalNumber(value: SecondsContainedIn.minute.rawValue)
    }

    public func getMoneyReceivedFromSeconds(workSeconds: TimeInterval) -> Money {
        return getSalaryPerSecond() * NSDecimalNumber(value: workSeconds)
    }

    public func isSelectedHoursValid(_ selectedHours: Int) -> Bool {
        return (selectedHours < workdays.count || selectedHours > workdays.count * 24)
    }

    private mutating func syncWorkdaysWithWorkHours() {
        if weeklyWorkHours < workdays.count {
            weeklyWorkHours = workdays.count
        } else if weeklyWorkHours > workdays.count*24 {
            weeklyWorkHours = workdays.count*24
        }
    }
}
