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
        XCTAssertEqual(getUnstoppedWorkTimeDescription(from: seconds), mockedFormatter.string(from: seconds))
    }
    
    func test_translate_60seconds_to1minute() {
        let seconds: TimeInterval = 1.minute
        XCTAssertEqual(getUnstoppedWorkTimeDescription(from: seconds), mockedFormatter.string(from: seconds))
    }

    func test_translate_5400seconds_to1hourAnd30min() {
        let seconds: TimeInterval = TimeInterval.from(hours: 1, minutes: 30)
        XCTAssertEqual(getUnstoppedWorkTimeDescription(from: seconds), mockedFormatter.string(from: seconds))
    }

    func test_translate_31537800seconds_to1YearAnd30minutes() {
        let seconds: TimeInterval = TimeInterval.from(years: 1, minutes: 30)
        XCTAssertEqual(getUnstoppedWorkTimeDescription(from: seconds), mockedFormatter.string(from: seconds))
    }

    func testTranslateTo1month() {
        let seconds: TimeInterval = 1.month
        XCTAssertEqual(getUnstoppedWorkTimeDescription(from: seconds), mockedFormatter.string(from: seconds))
    }

    func test_translate_0seconds_to0seconds() {
        let seconds: TimeInterval = 0
        XCTAssertEqual(getUnstoppedWorkTimeDescription(from: seconds), mockedFormatter.string(from: seconds))
    }
    
    func testGetWorkTimeDescriptionToPay() {
        let priceAsSeconds: Double = 3.hour
        let dailyWorkHours: Double = 1
        let weeklyWorkDays: Int = 3
        
        let result = getSUT().getWorkTimeDescriptionToPay(for: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        XCTAssertEqual(result, "3 days")
    }
    
    func testGetWorkTimeDescriptionToPay2() {
        let priceAsSeconds: Double = 1.hour
        let dailyWorkHours: Double = 1
        let weeklyWorkDays: Int = 1
        
        let result = getSUT().getWorkTimeDescriptionToPay(for: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        XCTAssertEqual(result, "1 hour")
    }
    
    func testGetWorkHoursRoutineFor10HoursReturnsNil() {
        let priceAsSeconds: TimeInterval = 10.hours
        let dailyWorkHours: Double = 8
        let weeklyWorkDays: Int = 5
        
        let result = getSUT().getWorkRoutineDescriptionToPay(for: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        XCTAssertNil(result)
    }
    
    func testGetWorkHoursRoutineFor48HoursReturnsDailyRoutine() {
        let priceAsSeconds: TimeInterval = 48.hours
        let dailyWorkHours: Double = 8
        let weeklyWorkDays: Int = 5

        let result = getSUT().getWorkRoutineDescriptionToPay(for: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)

        XCTAssertNotNil(result)
        XCTAssertEqual(result?.value, 8)
        XCTAssertEqual(result?.period, .daily)
    }
    
    func testGetWorkHoursRoutineFor2WeeksReturnsWeeklyRoutine() {
        let priceAsSeconds: TimeInterval = 2.weeks
        let dailyWorkHours: Double = 8
        let weeklyWorkDays: Int = 5

        let result = getSUT().getWorkRoutineDescriptionToPay(for: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)

        XCTAssertNotNil(result)
        XCTAssertEqual(result?.value, 8*5)
        XCTAssertEqual(result?.period, .weekly)
    }


    // MARK: Helpers
    
    func getSUT() -> TimeTextTranslator.Type {
        return TimeTextTranslator.self
    }
    
    func getUnstoppedWorkTimeDescription(from seconds: WorkTimeSeconds) -> String {
        TimeTextTranslator.allowedUnits = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second]
        return TimeTextTranslator.getUnstoppedWorkTimeDescription(from: seconds)
    }
    
    private let mockedFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second]
        return formatter
    }()

}
