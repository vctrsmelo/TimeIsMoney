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
