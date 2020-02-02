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
        
        XCTAssertEqual(sut.getAsMoney(for: user), .success(100.asMoney()))
    }
    
    func testStartValueSecondsGetSeconds() {
        let sut = makeSUT(value: .timeInSeconds(500))
        let user = getUser(salary: 8000, weeklyWorkHours: 40, weeklyWorkDays: 5)
        
        let result = sut.getAsTimeInSeconds(for: user)
        
        XCTAssertEqual(result, .success(500))
    }
    
    func testStartValueSecondsGetMoney() {
        let workSeconds: TimeInterval = 3600
        let sut = makeSUT(value: .timeInSeconds(workSeconds))
        let user = getUser(salary: 1000, weeklyWorkHours: 40, weeklyWorkDays: 5)

        let expectedResult = user.getMoneyReceivedFromSeconds(workSeconds: workSeconds)
        
        XCTAssertEqual(sut.getAsMoney(for: user), .success(expectedResult))
    }

    // MARK: - Helpers
    
    private func makeSUT(value: Value.ValueType) -> Value {
        return Value(valueType: value)
    }

}
