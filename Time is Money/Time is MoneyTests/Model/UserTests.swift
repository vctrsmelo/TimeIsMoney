//
//  UserTests.swift
//  Time is MoneyTests
//
//  Created by Victor Melo on 17/12/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import XCTest
@testable import Time_is_Money

class UserTests: XCTestCase {

    func test_isSelectedHoursValid_whenMinValue_expectTrue() {
        let sut = makeSUT()
        let expectedMinValue = sut.workdays.count

        let result = sut.isSelectedHoursValid(expectedMinValue)
        
        XCTAssertTrue(result)
    }
    
    func test_isSelectedHoursValid_whenMaxValue_expectTrue() {
        let sut = makeSUT()
        let expectedMaxValue = sut.workdays.count * 24
        
        let result = sut.isSelectedHoursValid(expectedMaxValue)
        
        XCTAssertTrue(result)
    }

    
    func test_isSelectedHoursValid_whenMinOutOfBounds_expectFalse() {
        let sut = makeSUT()
        let expectedMinOutOfBounds = sut.workdays.count - 1
        
        let result = sut.isSelectedHoursValid(expectedMinOutOfBounds)
        
        XCTAssertFalse(result)
    }

    
    func test_isSelectedHoursValid_whenMaxOutOfBounds_expectFalse() {
        let sut = makeSUT()
        let expectedMaxOutOfBounds = sut.workdays.count * 24 + 1
        
        let result = sut.isSelectedHoursValid(expectedMaxOutOfBounds)
        
        XCTAssertFalse(result)
    }

    
    // MARK: - Helpers
    func makeSUT() -> User {
        User()
    }

}
