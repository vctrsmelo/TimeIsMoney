//
//  XCTestCase+Extensions.swift
//  TimeIsMoneyCoreTests
//
//  Created by Victor Melo on 29/01/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation
import XCTest
@testable import TimeIsMoneyCore

extension XCTestCase {

    func getUser(salary: Double, weeklyWorkHours: Double, weeklyWorkDays: Int) -> User {
        
        var workdays: [Weekday] = [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday]
        
        let notWorkingDays = (1...(7 - weeklyWorkDays))
        
        notWorkingDays.forEach { _ in
            workdays.removeLast()
        }
        
        let user = User(testing: true)
        user.monthlySalary = salary.asDecimal()
        user.weeklyWorkHours = Int(weeklyWorkHours)
        user.workdays = workdays
        
        return user
    }

    func getSalaryPerSecond(user: User) -> NSDecimalNumber {
        let salaryPerWeek = NSDecimalNumber(decimal: user.monthlySalary) / WEEKS_IN_MONTH
        let salaryPerDay = salaryPerWeek / NSDecimalNumber(value: user.workdays.count)
        let salaryPerHour = salaryPerDay / NSDecimalNumber(value: user.dailyWorkHours)
        let salaryPerSecond = salaryPerHour / NSDecimalNumber(value: 3600)
        
        return salaryPerSecond
    }
    
    func getWorkTimeToPay(for moneyValue: Money, user: User) -> TimeInterval {
        return (moneyValue / getSalaryPerSecond(user: user)).asTimeInterval()
    }
    
    func getWorkTimeToPay(for moneyValue: Double, user: User) -> TimeInterval {
        return (Money(value: moneyValue) / getSalaryPerSecond(user: user)).asTimeInterval()
    }
}
