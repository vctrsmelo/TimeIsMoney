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

    func getUser(salary: Double = 1000, dailyWorkHours: Double, weeklyWorkDays: Int) -> User {
        
        let weeklyWorkHours = NSDecimalNumber(value: dailyWorkHours) * NSDecimalNumber(value: weeklyWorkDays)
        
        return getUser(salary: salary, weeklyWorkHours: weeklyWorkHours.timeIntervalValue, weeklyWorkDays: weeklyWorkDays)
    }
    
    func getUser(salary: Double = 1000, weeklyWorkHours: Double, weeklyWorkDays: Int) -> User {
        
        var workdays: [Weekday] = [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday]
        
        if weeklyWorkDays < 7 {
            let notWorkingDays = (1...(7 - weeklyWorkDays))
            
            notWorkingDays.forEach { _ in
                workdays.removeLast()
            }
        }
        
        let user = User(testing: true)
        user.monthlySalary = salary.asDecimal()
        user.weeklyWorkHours = Int(weeklyWorkHours)
        user.workdays = workdays
        
        return user
    }
    
    
}
