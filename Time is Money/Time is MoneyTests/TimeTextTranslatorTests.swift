//
//  TimeTextTranslatorTests.swift
//  TimeIsMoneyEngineTests
//
//  Created by Victor Melo on 18/11/19.
//  Copyright © 2019 Victor Melo. All rights reserved.
//

import XCTest
@testable import Time_is_Money

class TimeTextTranslatorTests: XCTestCase {
    
    // MARK: - Helper properties
    
    let oneYearInSeconds = NSDecimalNumber(value: 1.yearInSeconds)
    let sixMonthsInSeconds = NSDecimalNumber(value: 6.monthsInSeconds)
    let twoWeeksInSeconds = NSDecimalNumber(value: 2.weeksInSeconds)
    let fourDaysInSeconds = NSDecimalNumber(value: 4.daysInSeconds)
    let threeHoursInSeconds = NSDecimalNumber(value: 3.hoursInSeconds)
    let fourtyMinutesInSeconds = NSDecimalNumber(value: 40.minutesInSeconds)
    let fiftyFiveSeconds = NSDecimalNumber(value: 55)
    
    
    // MARK: - Year only tests
    
    func testGetWorkTimeFor1YearWith24hDailyWorkGet1Year() {
        let priceAsSeconds = NSDecimalNumber(value: 1.yearInSeconds)
        let user = getUser(dailyWorkHours: 24, weeklyWorkDays: 7)
        
        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, user: user)
        
        XCTAssertEqual(result.year, 1)
    }
    
    func testGetWorkTimeFor1YearWith12hDailyWorkGet2Years() {
        let priceAsSeconds = NSDecimalNumber(value: 1.yearInSeconds)
        let user = getUser(dailyWorkHours: 12, weeklyWorkDays: 7)
        
        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, user: user)
        
        XCTAssertEqual(result.year, 2)
    }
    
    // MARK: - Month only tests
    
    func testGetWorkTimeFor1MonthWith24hDailyWorkGet1Month() {
        let priceAsSeconds = NSDecimalNumber(value: 1.monthInSeconds)
        let user = getUser(dailyWorkHours: 24, weeklyWorkDays: 7)
        
        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, user: user)
        
        XCTAssertEqual(result.month, 1)
    }
    
    func testGetWorkTimeFor1MonthWith12hDailyWorkGet2Months() {
        let priceAsSeconds = NSDecimalNumber(value: 1.monthInSeconds)
        let user = getUser(dailyWorkHours: 12, weeklyWorkDays: 7)
        
        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, user: user)
        
        XCTAssertEqual(result.month, 2)
    }
    
    // MARK: Week only tests
    
    func testGetWorkTimeFor1WeekWith24hDailyWorkGet1Week() {
        let priceAsSeconds = NSDecimalNumber(value: 1.weekInSeconds)
        let user = getUser(dailyWorkHours: 24, weeklyWorkDays: 7)
        
        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, user: user)
        
        XCTAssertEqual(result.day, 7)
    }
    
    func testGetWorkTimeFor1WeekWith12hDailyWorkGet2Weeks() {
        let priceAsSeconds = NSDecimalNumber(value: 1.weekInSeconds)
        let user = getUser(dailyWorkHours: 12, weeklyWorkDays: 7)

        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, user: user)
        
        XCTAssertEqual(result.day, 14)
    }
    
    // MARK: Day only tests
    
    func testGetWorkTimeFor1DayWith24hDailyWorkGet1Day() {
        let priceAsSeconds = NSDecimalNumber(value: 1.dayInSeconds)
        let user = getUser(dailyWorkHours: 24, weeklyWorkDays: 7)
        
        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, user: user)
        
        XCTAssertEqual(result.day, 1)
    }
    
    func testGetWorkTimeFor1DayWith12hDailyWorkGet2Days() {
        let priceAsSeconds = NSDecimalNumber(value: 1.dayInSeconds)
        let user = getUser(dailyWorkHours: 12, weeklyWorkDays: 7)

        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, user: user)
        
        XCTAssertEqual(result.day, 2)
    }
    
    // MARK: Hour only tests
    
    func testGetWorkTimeFor16hoursWith24hDailyWorkGet16hours() {
        let priceAsSeconds = NSDecimalNumber(value: 16.hoursInSeconds)
        let user = getUser(dailyWorkHours: 24, weeklyWorkDays: 7)
        
        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, user: user)
        
        XCTAssertEqual(result.hour, 16)
    }
    
    func testGetWorkTimeFor12hoursWith12hDailyWorkGet2Days() {
        let priceAsSeconds = NSDecimalNumber(value: 1.dayInSeconds)
        let user = getUser(dailyWorkHours: 12, weeklyWorkDays: 7)

        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, user: user)
        
        XCTAssertEqual(result.day, 2)
    }
    
    // MARK: Minute only tests
    
    func testGetWorkTimeFor1MinuteWith24hDailyWorkGet1Minute() {
        let priceAsSeconds = NSDecimalNumber(value: 1.minuteInSeconds)
        let user = getUser(dailyWorkHours: 24, weeklyWorkDays: 7)
        
        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, user: user)
        
        XCTAssertEqual(result.minute, 1)
    }
    
    func testGetWorkTimeFor60MinutesWith12hDailyWorkGet1Hour() {
        let priceAsSeconds = NSDecimalNumber(value: 60.minutesInSeconds)
        let user = getUser(dailyWorkHours: 12, weeklyWorkDays: 7)

        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, user: user)
        
        XCTAssertEqual(result.hour, 1)
    }
    
    // MARK: Second only tests
    
    func testGetWorkTimeFor55SecondsWith24hDailyWorkGet55Seconds() {
        let priceAsSeconds = NSDecimalNumber(value: 55)
        let user = getUser(dailyWorkHours: 24, weeklyWorkDays: 7)
        
        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, user: user)
        
        XCTAssertEqual(result.second, 55)
    }
    
    func testGetWorkTimeFor125SecondsWith12hDailyWorkGet2MinutesAnd5Seconds() {
        let priceAsSeconds = NSDecimalNumber(value: 125)
        let user = getUser(dailyWorkHours: 12, weeklyWorkDays: 7)

        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, user: user)
        
        XCTAssertEqual(result.minute, 2)
        XCTAssertEqual(result.second, 5)
    }
    
    func testGetWorkTimeFor1Day() {
        let priceAsSeconds = NSDecimalNumber(value: 8.hoursInSeconds)
        let user = getUser(dailyWorkHours: 8, weeklyWorkDays: 5)

        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, user: user)

        XCTAssertEqual(result.day, 1)
    }

    func testGetWorkTimeFor2Days() {
        let priceAsSeconds = NSDecimalNumber(value: 16.hoursInSeconds)
        let user = getUser(dailyWorkHours: 8, weeklyWorkDays: 5)

        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, user: user)

        XCTAssertEqual(result.day, 2)
    }

    func testGetWorkTimeForHalfDay() {
        let priceAsSeconds = NSDecimalNumber(value: 4.hoursInSeconds)
        let user = getUser(dailyWorkHours: 8, weeklyWorkDays: 5)

        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, user: user)

        XCTAssertEqual(result.hour, 4)
    }

    func testGetWorkTimeDescriptionToPay() {
        let priceAsSeconds = NSDecimalNumber(value: 3.hourInSeconds)
        let user = getUser(dailyWorkHours: 1, weeklyWorkDays: 3)

        let result = getSUT().getWorkTimeDescriptionToPay(for: priceAsSeconds, user: user)

        XCTAssertEqual(result, "1 week")
    }

    func testGetWorkTimeDescriptionToPay2() {
        let priceAsSeconds = NSDecimalNumber(value: 1.hourInSeconds)
        let user = getUser(dailyWorkHours: 1, weeklyWorkDays: 1)

        let result = getSUT().getWorkTimeDescriptionToPay(for: priceAsSeconds, user: user)

        XCTAssertEqual(result, "1 week")
    }

    func testGetWorkHoursRoutineFor10HoursReturnsNil() {
        var components = DateComponents()
        components.hour = 10
        let user = getUser(dailyWorkHours: 8, weeklyWorkDays: 5)

        let result = getSUT().getWorkRoutineDescriptionToPay(for: components, dailyWorkHours: user.dailyWorkHours, weeklyWorkDays: user.weeklyWorkDays.intValue)

        XCTAssertNil(result)
    }

    func testGetWorkHoursRoutineFor2DaysReturnsDailyRoutine() {
        var components = DateComponents()
        components.day = 2
        let user = getUser(dailyWorkHours: 8, weeklyWorkDays: 5)

        let result = getSUT().getWorkRoutineDescriptionToPay(for: components, dailyWorkHours: user.dailyWorkHours, weeklyWorkDays: user.weeklyWorkDays.intValue)

        XCTAssertNotNil(result)
        XCTAssertEqual(result?.value, 8)
        XCTAssertEqual(result?.period, .daily)
    }

    func testGetWorkHoursRoutineFor2WeeksReturnsWeeklyRoutine() {
        var components = DateComponents()
        components.day = 14
        let user = getUser(dailyWorkHours: 8, weeklyWorkDays: 5)

        let result = getSUT().getWorkRoutineDescriptionToPay(for: components, dailyWorkHours: user.dailyWorkHours, weeklyWorkDays: user.weeklyWorkDays.intValue)

        XCTAssertNotNil(result)
        XCTAssertEqual(result?.value, 40)
        XCTAssertEqual(result?.period, .weekly)
    }

    // MARK: Helpers
    
    func getSUT() -> TimeTextTranslator.Type {
        return TimeTextTranslator.self
    }
    
    func getUnstoppedWorkTimeDescription(from seconds: TimeInterval) -> String {
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
