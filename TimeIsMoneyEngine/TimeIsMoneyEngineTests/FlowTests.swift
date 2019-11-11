//
//  FlowTests.swift
//  TimeIsMoneyEngineTests
//
//  Created by Victor Melo on 11/11/19.
//  Copyright © 2019 Victor Melo. All rights reserved.
//

import Foundation
import XCTest
@testable import TimeIsMoneyEngine

class FlowTests: XCTestCase {
    
    func test_start_withValueZero_presentTimeZero() {
        let sut = Flow()
        
        let salary: Double = 2000
        let weeklyWorkHours: Double = 40
        let weeklyWorkDays: Int = 5
        
        sut.start(initialValue: 0.00, salary: salary, weeklyWorkHours: weeklyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        XCTAssertEqual(sut.currentTimeInterval, 0.0)
    }
    
    func test_start_withValueTenAndSalary2000AndWeeklyWorkHours40_setCurrentTimeIntervalTo28800() {
        let sut = Flow()

        let salary: Double = 2000
        let weeklyWorkHours: Double = 40
        let weeklyWorkDays: Int = 5

        sut.start(initialValue: 100.00, salary: salary, weeklyWorkHours: weeklyWorkHours, weeklyWorkDays: weeklyWorkDays)

        XCTAssertEqual(sut.currentTimeInterval, 28800)
    }
    
}
