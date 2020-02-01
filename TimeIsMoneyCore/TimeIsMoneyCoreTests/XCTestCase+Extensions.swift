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
    
    
}
