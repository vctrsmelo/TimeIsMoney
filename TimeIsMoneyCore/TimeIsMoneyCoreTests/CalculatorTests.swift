//
//  CalculatorTests.swift
//  TimeIsMoneyCoreTests
//
//  Created by Victor Melo on 02/02/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import XCTest
@testable import TimeIsMoneyCore

class CalculatorTests: XCTestCase {

    func testDifferentWeeklyHoursReturnsSameResult() {
        let user1 = getUser(salary: 1000, weeklyWorkHours: 44, weeklyWorkDays: 5)
        let user2 = getUser(salary: 1000, weeklyWorkHours: 120, weeklyWorkDays: 5)
        
        let price = Money(value: 500_000)
        
        guard case .success(let notNormalizedWorkTime1) = getSUT().getWorkTimeToPay(for: price, user: user1) else { XCTFail(); return }
        guard case .success(let notNormalizedWorkTime2) = getSUT().getWorkTimeToPay(for: price, user: user2) else { XCTFail(); return }
        
        let normalizedWorkTime1 = TimeTextTranslator.getNormalizedWorkTimeFrom(priceAsSeconds: NSDecimalNumber(value: notNormalizedWorkTime1), user: user1)
        let normalizedWorkTime2 = TimeTextTranslator.getNormalizedWorkTimeFrom(priceAsSeconds: NSDecimalNumber(value: notNormalizedWorkTime2), user: user2)
        
        XCTAssertEqual(normalizedWorkTime1, normalizedWorkTime2)
    }

    // MARK: - Helpers
    private func getSUT() -> Calculator.Type {
        return Calculator.self
    }
    
}
