//
//  CurrencyTests.swift
//  TimeIsMoneyCoreTests
//
//  Created by Victor Melo on 31/01/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import XCTest
@testable import TimeIsMoneyCore

class ValueTests: XCTestCase {
    
    func testStartValueMoneyGetMoney() {
        let sut = makeSUT(value: .monetary(NSDecimalNumber(100)))
        let user = getUser(salary: 8000, weeklyWorkHours: 40, weeklyWorkDays: 5)
        
        XCTAssertEqual(sut.getAsMoney(for: user), 100)
    }
    
    func testStartValueSecondsGetSeconds() {
        let sut = makeSUT(value: .timeInSeconds(500))
        let user = getUser(salary: 8000, weeklyWorkHours: 40, weeklyWorkDays: 5)
        
        let result = sut.getAsTimeInSeconds(for: user)
        
        XCTAssertEqual(result, .success(500))
    }
    
    func testStartValueMoneyGetSeconds() {
        
        let sut = makeSUT(value: .monetary(NSDecimalNumber(100)))
        let user = getUser(salary: 1000, weeklyWorkHours: 40, weeklyWorkDays: 5)
        
        let salaryPerWeek = NSDecimalNumber(decimal: user.monthlySalary) / WEEKS_IN_MONTH
        let salaryPerDay = salaryPerWeek / NSDecimalNumber(value: 5)
        let salaryPerHour = salaryPerDay / NSDecimalNumber(value: 8)
        let salaryPerSecond = salaryPerHour / NSDecimalNumber(value: 3600)
        
        let expectedResult = NSDecimalNumber(100) / salaryPerSecond
        
        XCTAssertEqual(sut.getAsTimeInSeconds(for: user), .success(expectedResult.asTimeInterval()))
    }

    // MARK: - Helpers
    private func makeSUT(value: Value.ValueType) -> Value {
        return Value(valueType: value)
    }

}
