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
    
    func test_getTime_withValue0_returnsTimeZero() {
        let sut = getSUT(salary: 2000, weeklyWorkHours: 40, weeklyWorkDays: 5)
        XCTAssertEqual(sut.getTimeNeededToPay(for: 0.0), Result.success(0.0))
    }
    
    func test_getTime_withValue100_andSalary2000_andWeeklyWorkHours40_andWeeklyWorkDays5_getWorkTime28800() {
        let sut = getSUT(salary: 2000, weeklyWorkHours: 40, weeklyWorkDays: 5)
        
        XCTAssertEqual(sut.getTimeNeededToPay(for: 100), Result.success(28800))
    }
    
    func test_getTime_withValueNegative100_andWeeklyWorkHours40_andWeeklyWorkDays5_getWorkTime0() {
        let sut = getSUT(salary: 2000, weeklyWorkHours: 40, weeklyWorkDays: 5)
        
        XCTAssertEqual(sut.getTimeNeededToPay(for: -100), Result.success(0.0))
    }
    
    func test_getTime_withWeeklyWorkDays0_getCalculatorError() {
        let sut = getSUT(salary: 2000, weeklyWorkHours: 40, weeklyWorkDays: 0)
        
        XCTAssertEqual(sut.getTimeNeededToPay(for: 100), Result.failure(CalculatorError.undefinedWeeklyWorkDays))
    }
    
    func test_getTime_withWeeklyWorkHours0_getCalculatorError() {
        let sut = getSUT(salary: 2000, weeklyWorkHours: 0, weeklyWorkDays: 5)
        
        XCTAssertEqual(sut.getTimeNeededToPay(for: 100), Result.failure(CalculatorError.undefinedWeeklyWorkHours))
    }
    
    func test_getTime_withSalary0_getCalculatorError() {
        let sut = getSUT(salary: 0, weeklyWorkHours: 10, weeklyWorkDays: 5)
        
        XCTAssertEqual(sut.getTimeNeededToPay(for: 100), Result.failure(CalculatorError.undefinedSalary))
    }
    
    // MARK: Helpers
    
    func getSUT(salary: Double, weeklyWorkHours: Double, weeklyWorkDays: Int) -> Flow {
        return Flow(monthlySalary: salary, weeklyWorkHours: weeklyWorkHours, weeklyWorkDays: weeklyWorkDays)
    }
    
}
