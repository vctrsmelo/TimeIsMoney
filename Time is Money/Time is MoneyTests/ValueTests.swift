//
//  CurrencyTests.swift
//  TimeIsMoneyCoreTests
//
//  Created by Victor Melo on 31/01/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import XCTest
@testable import Time_is_Money

class ValueTests: XCTestCase {
    
    func testStartValueMoneyGetMoney() {
        let user = getUser(salary: 8000, weeklyWorkHours: 40, weeklyWorkDays: 5)
        let sut = makeSUT(value: .monetary(NSDecimalNumber(100)), user: user)
        
        XCTAssertEqual(sut.getAsMoney(), 100.asMoney())
    }
    
    func testStartValueSecondsGetSeconds() {
        let user = getUser(salary: 8000, weeklyWorkHours: 40, weeklyWorkDays: 5)
        let sut = makeSUT(value: .timeInSeconds(500), user: user)
        
        let result = sut.getAsTimeInSeconds()
        
        XCTAssertEqual(result, 500)
    }
    
    func testStartValueSecondsGetMoney() {
        let user = getUser(salary: 1000, weeklyWorkHours: 40, weeklyWorkDays: 5)
        let workSeconds: TimeInterval = 3600
        let sut = makeSUT(value: .timeInSeconds(workSeconds), user: user)

        let expectedResult = user.getMoneyReceivedFromSeconds(workSeconds: workSeconds)
        
        XCTAssertEqual(sut.getAsMoney(), expectedResult)
    }

    // MARK: - Helpers
    
    private func makeSUT(value: Value.ValueType, user: User) -> Value {
        return Value(valueType: value, user: user)
    }

}
