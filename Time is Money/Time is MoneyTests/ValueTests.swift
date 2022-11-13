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
        let sut = makeSUT(value: .currency(NSDecimalNumber(100)), user: user)
        
        XCTAssertEqual(sut.getAsCurrency(), 100.asCurrency())
    }
    
    func testStartValueSecondsGetSeconds() {
        let user = getUser(salary: 8000, weeklyWorkHours: 40, weeklyWorkDays: 5)
        let sut = makeSUT(value: .seconds(500), user: user)
        
        let result = sut.getAsTimeInSeconds()
        
        XCTAssertEqual(result, 500)
    }
    
    func testStartValueSecondsGetMoney() {
        let user = getUser(salary: 1000, weeklyWorkHours: 40, weeklyWorkDays: 5)
        let workSeconds: TimeInterval = 3600
        let sut = makeSUT(value: .seconds(workSeconds), user: user)

        let expectedResult = user.getCurrencyReceivedFromSeconds(workSeconds: workSeconds)
        
        XCTAssertEqual(sut.getAsCurrency(), expectedResult)
    }

    // MARK: - Helpers
    
    private func makeSUT(value: Price.MonetaryUnit, user: User) -> Price {
        return Price(valueType: value, user: user)
    }

}
