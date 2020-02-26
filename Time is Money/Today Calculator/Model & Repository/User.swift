//
//  User.swift
//  Today Calculator
//
//  Created by Victor Melo on 26/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation

typealias Money = NSDecimalNumber

struct User {
    public var isOnboardingCompleted: Bool = false
    public var monthlySalary: Decimal = 1000
    
    public var weeklyWorkHours: Int = 40 {
        didSet {
            syncWorkdaysWithWorkHours()
        }
    }
    
    public var workdays: [WidgetWeekday] = WidgetWeekday.weekdays() {
        didSet {
            syncWorkdaysWithWorkHours()
        }
    }
    
    // MARK: Methods
    
    func isSelectedHoursValid(_ selectedHours: Int) -> Bool {
        return (selectedHours < workdays.count || selectedHours > workdays.count * 24)
    }

    private mutating func syncWorkdaysWithWorkHours() {
        if weeklyWorkHours < workdays.count {
            weeklyWorkHours = workdays.count
        } else if weeklyWorkHours > workdays.count*24 {
            weeklyWorkHours = workdays.count*24
        }
    }
    
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
        getSalaryPerMinute() / NSDecimalNumber(value: SecondsContainedIn.minute.rawValue)
    }

    func getMoneyReceivedFromSeconds(workSeconds: TimeInterval) -> Money {
        return getSalaryPerSecond() * NSDecimalNumber(value: workSeconds)
    }
}

extension User {
    
    var weeklyWorkDays: NSDecimalNumber {
        NSDecimalNumber(value: workdays.count)
    }
    
    var dailyWorkHours: NSDecimalNumber {
        guard weeklyWorkDays > 0 else { return NSDecimalNumber(value: 0) }
        return NSDecimalNumber(value: weeklyWorkHours) / weeklyWorkDays
    }
    
    public var yearlyWorkSeconds: NSDecimalNumber {
        monthlyWorkSeconds * NSDecimalNumber(value: 12)
    }
    
    public var monthlyWorkSeconds: NSDecimalNumber {
        weeklyWorkSeconds * WEEKS_IN_MONTH
    }
    
    public var weeklyWorkSeconds: NSDecimalNumber {
        NSDecimalNumber(value: weeklyWorkHours) * NSDecimalNumber(value: SecondsContainedIn.hour.asDouble())
    }
    
    public var dailyWorkSeconds: NSDecimalNumber {
        dailyWorkHours * NSDecimalNumber(value: 1.hourInSeconds)
    }
    
    public var hourWorkSeconds: NSDecimalNumber {
        NSDecimalNumber(value: 3600)
    }
    
    public var minuteWorkSeconds: NSDecimalNumber {
        NSDecimalNumber(value: 60)
    }
    
    public var secondWorkSeconds: NSDecimalNumber {
        NSDecimalNumber(value: 1)
    }
}
