//
//  XCTestCase+Extensions.swift
//  TimeIsMoneyCoreTests
//
//  Created by Victor Melo on 29/01/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation
import XCTest
@testable import Time_is_Money

extension XCTestCase {

    func getUser(salary: Double = 1000, dailyWorkHours: Double, weeklyWorkDays: Int) -> User {
        
        let weeklyWorkHours = NSDecimalNumber(value: dailyWorkHours) * NSDecimalNumber(value: weeklyWorkDays)
        
        return getUser(salary: salary, weeklyWorkHours: weeklyWorkHours.intValue, weeklyWorkDays: weeklyWorkDays)
    }
    
    func getUser(salary: Double = 1000, weeklyWorkHours: Int, weeklyWorkDays: Int) -> User {
        
        var workdays: [Weekday] = [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday]
        
        if weeklyWorkDays < 7 {
            let notWorkingDays = (1...(7 - weeklyWorkDays))
            
            notWorkingDays.forEach { _ in
                workdays.removeLast()
            }
        }
        
        return User(isOnboardingCompleted: true, monthlySalary: salary.asNSDecimalNumber(), weeklyWorkHours: weeklyWorkHours, workdays: workdays)
    }
    
    
}
