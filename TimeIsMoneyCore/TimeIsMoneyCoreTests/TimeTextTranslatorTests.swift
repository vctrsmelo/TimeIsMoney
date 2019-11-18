//
//  TimeTextTranslatorTests.swift
//  TimeIsMoneyEngineTests
//
//  Created by Victor Melo on 18/11/19.
//  Copyright © 2019 Victor Melo. All rights reserved.
//

import XCTest
@testable import TimeIsMoneyCore

class TimeTextTranslatorTests: XCTestCase {
    
    func test_translate_1second_to1second() {
        let seconds: TimeInterval = 1
        XCTAssertEqual(getSUT().getDescription(from: seconds), mockedFormatter.string(from: seconds))
    }
    
    func test_translate_60seconds_to1minute() {
        let seconds: TimeInterval = 60
        XCTAssertEqual(getSUT().getDescription(from: seconds), mockedFormatter.string(from: seconds))
    }
    
    func test_translate_5400seconds_to1hourAnd30min() {
        let seconds: TimeInterval = 5400
        XCTAssertEqual(getSUT().getDescription(from: seconds), mockedFormatter.string(from: seconds))
    }
    
    func test_translate_31537800seconds_to1YearAnd30minutes() {
        let seconds: TimeInterval = 31537800
        XCTAssertEqual(getSUT().getDescription(from: seconds), mockedFormatter.string(from: seconds))
    }
    
    func test_translate_2678400seconds_to1month() {
        let seconds: TimeInterval = 2678400
        XCTAssertEqual(getSUT().getDescription(from: seconds), mockedFormatter.string(from: seconds))
    }
    
    func test_translate_0seconds_to0seconds() {
        let seconds: TimeInterval = 0
        XCTAssertEqual(getSUT().getDescription(from: seconds), mockedFormatter.string(from: seconds))
    }
    
    // MARK: Helpers
    
    func getSUT() -> TimeTextTranslator.Type {
        return TimeTextTranslator.self
    }
    
    private let mockedFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .weekOfMonth, .hour, .minute, .second]
        return formatter
    }()

}
