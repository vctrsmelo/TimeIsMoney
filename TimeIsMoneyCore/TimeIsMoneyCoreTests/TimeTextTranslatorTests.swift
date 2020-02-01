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
    
    func testGetWorkTimeFor1YearWith24hDailyWorkGet1Year() {
        let priceAsSeconds: Double = 1.yearInSeconds
        let dailyWorkHours: Double = 24
        let weeklyWorkDays: Int = 7
        
        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        XCTAssertEqual(result.doubleValue, 1.yearInSeconds)
    }
    
    func testGetWorkTimeFor1YearWith12hDailyWorkGet2Years() {
        let priceAsSeconds: Double = 1.yearInSeconds
        let dailyWorkHours: Double = 12
        let weeklyWorkDays: Int = 7
        
        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        XCTAssertEqual(result.doubleValue, 2.yearsInSeconds)
    }
    
    func testGetWorkTimeFor1Day() {
        let priceAsSeconds: Double = 8.hoursInSeconds
        let dailyWorkHours: Double = 8
        let weeklyWorkDays: Int = 5
        
        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        XCTAssertEqual(result.doubleValue, 1.dayInSeconds)
    }
    
    func testGetWorkTimeFor2Days() {
        let priceAsSeconds: Double = 16.hoursInSeconds
        let dailyWorkHours: Double = 8
        let weeklyWorkDays: Int = 5
        
        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        XCTAssertEqual(result.doubleValue, 2.daysInSeconds)
    }
    
    func testGetWorkTimeForHalfDay() {
        let priceAsSeconds: Double = 4.hoursInSeconds
        let dailyWorkHours: Double = 8
        let weeklyWorkDays: Int = 5

        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)

        XCTAssertEqual(result.doubleValue, 4.hoursInSeconds)
    }
    
    func testGetWorkTimeDescriptionToPay() {
        let priceAsSeconds: Double = 3.hourInSeconds
        let dailyWorkHours: Double = 1
        let weeklyWorkDays: Int = 3
        
        let result = getSUT().getWorkTimeDescriptionToPay(for: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        XCTAssertEqual(result, "3 days")
    }
    
    func testGetWorkTimeDescriptionToPay2() {
        let priceAsSeconds: Double = 1.hourInSeconds
        let dailyWorkHours: Double = 1
        let weeklyWorkDays: Int = 1
        
        let result = getSUT().getWorkTimeDescriptionToPay(for: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        XCTAssertEqual(result, "1 hour")
    }
    
    func testGetWorkHoursRoutineFor10HoursReturnsNil() {
        let priceAsSeconds = NSDecimalNumber(value: 10.hoursInSeconds)
        let dailyWorkHours: Double = 8
        let weeklyWorkDays: Int = 5
        
        let result = getSUT().getWorkRoutineDescriptionToPay(for: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        XCTAssertNil(result)
    }
    
    func testGetWorkHoursRoutineFor48HoursReturnsDailyRoutine() {
        let priceAsSeconds = NSDecimalNumber(value: 48.hoursInSeconds)
        let dailyWorkHours: Double = 8
        let weeklyWorkDays: Int = 5

        let result = getSUT().getWorkRoutineDescriptionToPay(for: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)

        XCTAssertNotNil(result)
        XCTAssertEqual(result?.value, 8)
        XCTAssertEqual(result?.period, .daily)
    }
    
    func testGetWorkHoursRoutineFor2WeeksReturnsWeeklyRoutine() {
        let priceAsSeconds = NSDecimalNumber(value: 2.weeksInSeconds)
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
