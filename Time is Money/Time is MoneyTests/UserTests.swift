//
//  UserTests.swift
//  TimeIsMoneyCoreTests
//
//  Created by Victor Melo on 29/01/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import XCTest
import TimeIsMoneyCore

class UserTests: XCTestCase {

    func testDailyWorkHours() {
        XCTAssertEqual(getSUT(workTime: .daily(hours: 8)).dailyWorkHours, 8)
        XCTAssertEqual(getSUT(workTime: .weekly(hours: 44)).dailyWorkHours, (44.0/5.0))
    }
    
    func testWeeklyWorkHours() {
        XCTAssertEqual(getSUT(workTime: .weekly(hours: 40)).weeklyWorkHours, 40)
    }
    
    // MARK: - Helpers
    
    func getSUT(salary: Double = 0.0, workTime: WorkTimeMeasure, weeklyWorkDays: Int = 5) -> User {
        
        let weeklyWorkHours: Double
        switch workTime {
        case .daily(let time):
            weeklyWorkHours = time * Double(weeklyWorkDays)
        case .weekly(let time):
            weeklyWorkHours = time
        }
        
        return getUser(salary: salary, weeklyWorkHours: weeklyWorkHours, weeklyWorkDays: weeklyWorkDays)
    }
    
    enum WorkTimeMeasure {
        case daily(hours: Double)
        case weekly(hours: Double)
    }
}
