//
//  CalculatorTests.swift
//  TimeIsMoneyCoreTests
//
//  Created by Victor Melo on 02/02/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import XCTest
@testable import Time_is_Money

class CalculatorTests: XCTestCase {

    func testDifferentWeeklyHoursReturnsSameResult() {
        let user1 = getUser(salary: 1000, weeklyWorkHours: 44, weeklyWorkDays: 5)
        let user2 = getUser(salary: 1000, weeklyWorkHours: 120, weeklyWorkDays: 5)
        
        let price = Currency(value: 500_000)
        
        guard case .success(let notNormalizedWorkTime1) = getSUT().getWorkTimeToPay(for: price, user: user1) else { XCTFail(); return }
        guard case .success(let notNormalizedWorkTime2) = getSUT().getWorkTimeToPay(for: price, user: user2) else { XCTFail(); return }
        
        let normalizedWorkTime1 = TimeTextTranslator.getNormalizedWorkTimeFrom(priceAsSeconds: notNormalizedWorkTime1, user: user1)
        let normalizedWorkTime2 = TimeTextTranslator.getNormalizedWorkTimeFrom(priceAsSeconds: notNormalizedWorkTime2, user: user2)
        
        XCTAssertEqual(normalizedWorkTime1, normalizedWorkTime2)
    }
    
    func testGreaterValueReturnsGreaterResult() {
        let user = getUser(salary: 6600, weeklyWorkHours: 40, weeklyWorkDays: 5)
        
        let lowerPrice = Currency(value: 1)
        let biggerPrice = Currency(value: 10)
        
        guard case .success(let lowerNotNormalizedTime) = getSUT().getWorkTimeToPay(for: lowerPrice, user: user) else { XCTFail(); return }
        guard case .success(let biggerNotNormalizedTime) = getSUT().getWorkTimeToPay(for: biggerPrice, user: user) else { XCTFail(); return }
        
        let lowerNormalizedTime = TimeTextTranslator.getNormalizedWorkTimeFrom(priceAsSeconds: lowerNotNormalizedTime, user: user)
        let biggerNormalizedTime = TimeTextTranslator.getNormalizedWorkTimeFrom(priceAsSeconds: biggerNotNormalizedTime, user: user)
        
        XCTAssertGreaterThan(biggerNotNormalizedTime, lowerNotNormalizedTime)
        XCTAssertGreaterThan(biggerNormalizedTime, lowerNormalizedTime)
    }
    
    func testGetTimeWithZeroPriceReturnsZero() {
        let user = getUser(salary: 2000, weeklyWorkHours: 40, weeklyWorkDays: 5)
        
        XCTAssertEqual(getSUT().getWorkTimeToPay(for: 0.0, user: user), Result.success(0.0))
    }
    
    func testGetTimeWithNegativePriceReturnsZero() {
        let user = getUser(salary: 2000, weeklyWorkHours: 40, weeklyWorkDays: 5)
        
        XCTAssertEqual(getSUT().getWorkTimeToPay(for: -100, user: user), Result.success(0.0))
    }
    
    func testGetTimeWithZeroWorkdaysReturnsUndefinedWeeklyWorkDaysError() {
        let user = getUser(salary: 2000, weeklyWorkHours: 40, weeklyWorkDays: 0)
        
        XCTAssertEqual(getSUT().getWorkTimeToPay(for: 100, user: user), Result.failure(CalculatorError.undefinedWeeklyWorkDays))
    }
    
    func testGetTimeWithZeroWorkhoursReturnsUndefinedWeeklyWorkHoursError() {
        let user = getUser(salary: 2000, weeklyWorkHours: 0, weeklyWorkDays: 5)
        
        XCTAssertEqual(getSUT().getWorkTimeToPay(for: 100, user: user), Result.failure(.undefinedWeeklyWorkHours))
    }
    
    func testGetTimeWithZeroSalaryReturnsUndefinedSalaryError() {
        let user = getUser(salary: 0, weeklyWorkHours: 40, weeklyWorkDays: 5)
        
        XCTAssertEqual(getSUT().getWorkTimeToPay(for: 100, user: user), Result.failure(CalculatorError.undefinedSalary))
    }
    

    // MARK: - Helpers
    private func getSUT() -> Calculator.Type {
        return Calculator.self
    }
    
}
