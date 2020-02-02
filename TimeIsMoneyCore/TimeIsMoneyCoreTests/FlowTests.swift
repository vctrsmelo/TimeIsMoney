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
    
    func testGetTimeWithNegativePriceReturnsZero() {
        let sut = getSUT(salary: 2000, weeklyWorkHours: 40, weeklyWorkDays: 5)
        
        XCTAssertEqual(sut.getTimeNeededToPay(forDouble: -100), Result.success(0.0))
    }
    
    func testGetTimeWithZeroWorkdaysReturnsUndefinedWeeklyWorkDaysError() {
        let sut = getSUT(salary: 2000, weeklyWorkHours: 40, weeklyWorkDays: 0)
        
        XCTAssertEqual(sut.getTimeNeededToPay(forDouble: 100), Result.failure(CalculatorError.undefinedWeeklyWorkDays))
    }
    
    func testGetTimeWithZeroWorkhoursReturnsUndefinedWeeklyWorkHoursError() {
        let sut = getSUT(salary: 2000, weeklyWorkHours: 0, weeklyWorkDays: 5)
        
        XCTAssertEqual(sut.getTimeNeededToPay(forDouble: 100), Result.failure(.undefinedWeeklyWorkHours))
    }
    
    func testGetTimeWithZeroSalaryReturnsUndefinedSalaryError() {
        let sut = getSUT(salary: 0, weeklyWorkHours: 10, weeklyWorkDays: 5)
        
        XCTAssertEqual(sut.getTimeNeededToPay(forDouble: 100), Result.failure(CalculatorError.undefinedSalary))
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
