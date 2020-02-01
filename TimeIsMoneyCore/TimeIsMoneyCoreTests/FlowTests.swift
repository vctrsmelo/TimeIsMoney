//
//  FlowTests.swift
//  TimeIsMoneyEngineTests
//
//  Created by Victor Melo on 11/11/19.
//  Copyright © 2019 Victor Melo. All rights reserved.
//

import Foundation
import XCTest
@testable import TimeIsMoneyCore

class FlowTests: XCTestCase {
    
    func testGetTimeWithZeroPriceReturnsZero() {
        let sut = getSUT(salary: 2000, weeklyWorkHours: 40, weeklyWorkDays: 5)
        XCTAssertEqual(sut.getTimeNeededToPay(for: 0.0), Result.success(0.0))
    }
    
    func testGetTimeWithValidPriceReturnsCorrectWorkTime() {
        let sut1 = getSUT(salary: 2000, weeklyWorkHours: 40, weeklyWorkDays: 5)
        let sut2 = getSUT(salary: 1000, weeklyWorkHours: 1, weeklyWorkDays: 1)
        
        let expectedWorkTime1 = getWorkTimeToPay(for: 100.0, user: sut1.user)
        let expectedWorkTime2 = getWorkTimeToPay(for: 250.0, user: sut2.user)
        
        XCTAssertEqual(sut1.getTimeNeededToPay(for: 100), .success(expectedWorkTime1))
        XCTAssertEqual(sut2.getTimeNeededToPay(for: 250), .success(expectedWorkTime2))
    }
    
    func testGetTimeWithNegativePriceReturnsZero() {
        let sut = getSUT(salary: 2000, weeklyWorkHours: 40, weeklyWorkDays: 5)
        
        XCTAssertEqual(sut.getTimeNeededToPay(for: -100), Result.success(0.0))
    }
    
    func testGetTimeWithZeroWorkdaysReturnsUndefinedWeeklyWorkDaysError() {
        let sut = getSUT(salary: 2000, weeklyWorkHours: 40, weeklyWorkDays: 0)
        
        XCTAssertEqual(sut.getTimeNeededToPay(for: 100), Result.failure(CalculatorError.undefinedWeeklyWorkDays))
    }
    
    func testGetTimeWithZeroWorkhoursReturnsUndefinedWeeklyWorkHoursError() {
        let sut = getSUT(salary: 2000, weeklyWorkHours: 0, weeklyWorkDays: 5)
        
        XCTAssertEqual(sut.getTimeNeededToPay(for: 100), Result.failure(.undefinedWeeklyWorkHours))
    }
    
    func testGetTimeWithZeroSalaryReturnsUndefinedSalaryError() {
        let sut = getSUT(salary: 0, weeklyWorkHours: 10, weeklyWorkDays: 5)
        
        XCTAssertEqual(sut.getTimeNeededToPay(for: 100), Result.failure(CalculatorError.undefinedSalary))
    }
    
    // MARK: Helpers
    
    func getSUT(salary: Double, weeklyWorkHours: Double, weeklyWorkDays: Int) -> Flow {
        let user = getUser(salary: salary, weeklyWorkHours: weeklyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        return Flow(user: user)
    }
    
    func resultFloorAsHour(_ result: Result<WorkTimeSeconds, CalculatorError>) -> Double? {
        switch result {
        case .success(let worktime):
            return floor(worktime/3600)*3600
        default:
            return nil
        }
    }
}

enum Time {
    case hours(_ v: Double)
    
    func asSeconds() -> TimeInterval {
        switch self {
        case .hours(let v):
            return v*3600
        }
    }
}
