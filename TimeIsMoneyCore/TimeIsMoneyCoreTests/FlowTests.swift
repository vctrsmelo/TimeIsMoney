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
    
    func test_getTime_withValue0_returnsTimeZero() {
        let sut = getSUT(salary: 2000, weeklyWorkHours: 40, weeklyWorkDays: 5)
        XCTAssertEqual(sut.getTimeNeededToPay(for: 0.0), Result.success(0.0))
    }
    
    func test_getTime_withValue100_andSalary2000_andWeeklyWorkHours40_andWeeklyWorkDays5_getWorkTime28800() {
        let sut = getSUT(salary: 2000, weeklyWorkHours: 40, weeklyWorkDays: 5)
        
        let floorHour = resultFloorAsHour(sut.getTimeNeededToPay(for: 100))
        
        XCTAssertEqual(floorHour, Time.hours(8).asSeconds())
    }
    
    func test_getTime_withValueNegative100_andWeeklyWorkHours40_andWeeklyWorkDays5_getWorkTime0() {
        let sut = getSUT(salary: 2000, weeklyWorkHours: 40, weeklyWorkDays: 5)
        
        XCTAssertEqual(sut.getTimeNeededToPay(for: -100), Result.success(0.0))
    }
    
    func test_getTime_withWeeklyWorkDays0_getCalculatorError() {
        let sut = getSUT(salary: 2000, weeklyWorkHours: 40, weeklyWorkDays: 0)
        
        XCTAssertEqual(sut.getTimeNeededToPay(for: 100), Result.failure(CalculatorError.undefinedWeeklyWorkDays))
    }
    
    func test_getTime_withWeeklyWorkHours0_AndWorkdays5_getUndefinedWeeklyWorkHours() {
        let sut = getSUT(salary: 2000, weeklyWorkHours: 0, weeklyWorkDays: 5)
        
        XCTAssertEqual(sut.getTimeNeededToPay(for: 100), Result.failure(.undefinedWeeklyWorkHours))
    }
    
    func test_getTime_withSalary0_getCalculatorError() {
        let sut = getSUT(salary: 0, weeklyWorkHours: 10, weeklyWorkDays: 5)
        
        XCTAssertEqual(sut.getTimeNeededToPay(for: 100), Result.failure(CalculatorError.undefinedSalary))
    }
    
    func test_getTime_withSalary1000_AndWeeklyHours1_Value250_get1Hour() {
        let sut = getSUT(salary: 1000, weeklyWorkHours: 1, weeklyWorkDays: 1)

        XCTAssertEqual(sut.getTimeNeededToPay(for: 250), Result.success(3982.300884955752))
    }

    // MARK: Helpers
    
    func getSUT(salary: Double, weeklyWorkHours: Double, weeklyWorkDays: Int) -> Flow {

        var workdays: [Weekday] = [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday]
        
        (1...(7 - weeklyWorkDays)).forEach { _ in
            workdays.removeLast()
        }
        
        let testUser = User(testing: true)
        testUser.monthlySalary = salary.asDecimal()
        testUser.weeklyWorkHours = Int(weeklyWorkHours)
        testUser.workdays = workdays

        return Flow(user: testUser)
    }
    
    func resultFloorAsHour(_ result: Result<WorkTime, CalculatorError>) -> Double? {
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
