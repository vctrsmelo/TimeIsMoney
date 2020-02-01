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
    
    // MARK: - Year only tests
    
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
    
    // MARK: - Month only tests
    
    func testGetWorkTimeFor1MonthWith24hDailyWorkGet1Month() {
        let priceAsSeconds: Double = 1.monthInSeconds
        let dailyWorkHours: Double = 24
        let weeklyWorkDays: Int = 7
        
        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        XCTAssertEqual(result.doubleValue, 1.monthInSeconds)
    }
    
    func testGetWorkTimeFor1MonthWith12hDailyWorkGet2Months() {
        let priceAsSeconds: Double = 1.monthInSeconds
        let dailyWorkHours: Double = 12
        let weeklyWorkDays: Int = 7
        
        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        XCTAssertEqual(result.doubleValue, 2.monthInSeconds)
    }
    
    // MARK: Week only tests
    
    func testGetWorkTimeFor1WeekWith24hDailyWorkGet1Week() {
        let priceAsSeconds: Double = 1.weekInSeconds
        let dailyWorkHours: Double = 24
        let weeklyWorkDays: Int = 7
        
        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        XCTAssertEqual(result.doubleValue, 1.weekInSeconds)
    }
    
    func testGetWorkTimeFor1WeekWith12hDailyWorkGet2Weeks() {
        let priceAsSeconds: Double = 1.weekInSeconds
        let dailyWorkHours: Double = 12
        let weeklyWorkDays: Int = 7

        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        XCTAssertEqual(result.doubleValue, 2.weeksInSeconds)
    }
    
    // MARK: Day only tests
    
    func testGetWorkTimeFor1DayWith24hDailyWorkGet1Day() {
        let priceAsSeconds: Double = 1.dayInSeconds
        let dailyWorkHours: Double = 24
        let weeklyWorkDays: Int = 7
        
        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        XCTAssertEqual(result.doubleValue, 1.dayInSeconds)
    }
    
    func testGetWorkTimeFor1DayWith12hDailyWorkGet2Days() {
        let priceAsSeconds: Double = 1.dayInSeconds
        let dailyWorkHours: Double = 12
        let weeklyWorkDays: Int = 7

        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        XCTAssertEqual(result.doubleValue, 2.daysInSeconds)
    }
    
    // MARK: Hour only tests
    
    func testGetWorkTimeFor16hoursWith24hDailyWorkGet16hours() {
        let priceAsSeconds: Double = 16.hoursInSeconds
        let dailyWorkHours: Double = 24
        let weeklyWorkDays: Int = 7
        
        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        XCTAssertEqual(result.doubleValue, 16.hoursInSeconds)
    }
    
    func testGetWorkTimeFor12hoursWith12hDailyWorkGet1Day() {
        let priceAsSeconds: Double = 1.dayInSeconds
        let dailyWorkHours: Double = 12
        let weeklyWorkDays: Int = 7

        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        XCTAssertEqual(result.doubleValue, 2.daysInSeconds)
    }
    
    // MARK: Minute only tests
    
    func testGetWorkTimeFor1MinuteWith24hDailyWorkGet1Minute() {
        let priceAsSeconds: Double = 1.minuteInSeconds
        let dailyWorkHours: Double = 24
        let weeklyWorkDays: Int = 7
        
        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        XCTAssertEqual(result.doubleValue, 1.minuteInSeconds)
    }
    
    func testGetWorkTimeFor60MinutesWith12hDailyWorkGet1Hour() {
        let priceAsSeconds: Double = 60.minutesInSeconds
        let dailyWorkHours: Double = 12
        let weeklyWorkDays: Int = 7

        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        XCTAssertEqual(result.doubleValue, 1.hourInSeconds)
    }
    
    // MARK: Second only tests
    
    func testGetWorkTimeFor55SecondsWith24hDailyWorkGet55Seconds() {
        let priceAsSeconds: Double = 55
        let dailyWorkHours: Double = 24
        let weeklyWorkDays: Int = 7
        
        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        XCTAssertEqual(result.doubleValue, 55)
    }
    
    func testGetWorkTimeFor125SecondsWith12hDailyWorkGet2MinutesAnd5Seconds() {
        let priceAsSeconds: Double = 125
        let dailyWorkHours: Double = 12
        let weeklyWorkDays: Int = 7

        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        XCTAssertEqual(result.doubleValue, (2.minuteInSeconds + 5))
    }
    
    // MARK: Year and month only tests
    
    func testGetWorkTimeFor1YearAnd6MonthsWith24hDailyWorkGet1YearAnd6Months() {
        let oneYearInSeconds = NSDecimalNumber(value: 1.yearInSeconds)
        let sixMonthsInSeconds = NSDecimalNumber(value: 6.monthsInSeconds)
        
        let priceAsSeconds: Double = (oneYearInSeconds + sixMonthsInSeconds).doubleValue
        let dailyWorkHours: Double = 24
        let weeklyWorkDays: Int = 7
        
        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        XCTAssertEqual(result.doubleValue, priceAsSeconds)
    }
    
    func testGetWorkTimeFor1YearAnd6MonthsWith12hDailyWorkGet3Years() {
        let oneYearInSeconds = NSDecimalNumber(value: 1.yearInSeconds)
        let sixMonthsInSeconds = NSDecimalNumber(value: 6.monthsInSeconds)
        
        let priceAsSeconds: Double = (oneYearInSeconds + sixMonthsInSeconds).doubleValue
        let dailyWorkHours: Double = 12
        let weeklyWorkDays: Int = 7
        
        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
    
        XCTAssertEqual(result.doubleValue, NSDecimalNumber(value: 3.yearsInSeconds).doubleValue)
    }
    
    // MARK: Year, month and week
    
    func testGetWorkTimeFor1YearAnd6MonthsAnd2WeeksWith12hDailyWorkGetTwiceWorkTimeNeeded() {
       let oneYearInSeconds = NSDecimalNumber(value: 1.yearInSeconds)
       let sixMonthsInSeconds = NSDecimalNumber(value: 6.monthsInSeconds)
       let twoWeeksInSeconds = NSDecimalNumber(value: 2.weeksInSeconds)
       
       let priceAsSeconds: Double = (oneYearInSeconds + sixMonthsInSeconds + twoWeeksInSeconds).doubleValue
       let dailyWorkHours: Double = 12
       let weeklyWorkDays: Int = 7
       
       let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
       
        let expectedResult = NSDecimalNumber(value: priceAsSeconds) * NSDecimalNumber(value: 2)
        XCTAssertEqual(result.doubleValue, expectedResult.doubleValue)
   }
    
    // MARK: Year, month, week and day
     
     func testGetWorkTimeFor1YearAnd6MonthsAnd2WeeksAnd4DaysWith12hDailyWorkGetTwiceWorkTimeNeeded() {
        let oneYearInSeconds = NSDecimalNumber(value: 1.yearInSeconds)
        let sixMonthsInSeconds = NSDecimalNumber(value: 6.monthsInSeconds)
        let twoWeeksInSeconds = NSDecimalNumber(value: 2.weeksInSeconds)
        let fourDaysInSeconds = NSDecimalNumber(value: 4.daysInSeconds)
        
        let priceAsSeconds: Double = (oneYearInSeconds + sixMonthsInSeconds + twoWeeksInSeconds + fourDaysInSeconds).doubleValue
        let dailyWorkHours: Double = 12
        let weeklyWorkDays: Int = 7
        
        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
         let expectedResult = NSDecimalNumber(value: priceAsSeconds) * NSDecimalNumber(value: 2)
         XCTAssertEqual(result.doubleValue, expectedResult.doubleValue)
    }
    
    // MARK: Year, month, week, day and hours
     
     func testGetWorkTimeFor1y6m2w4d3hWith12hDailyWorkTimeGetsTwiceWorkTimeNeeded() {
        let oneYearInSeconds = NSDecimalNumber(value: 1.yearInSeconds)
        let sixMonthsInSeconds = NSDecimalNumber(value: 6.monthsInSeconds)
        let twoWeeksInSeconds = NSDecimalNumber(value: 2.weeksInSeconds)
        let fourDaysInSeconds = NSDecimalNumber(value: 4.daysInSeconds)
        let threeHoursInSeconds = NSDecimalNumber(value: 3.hoursInSeconds)
        
        let priceAsSeconds = (oneYearInSeconds + sixMonthsInSeconds + twoWeeksInSeconds + fourDaysInSeconds + threeHoursInSeconds)
        let dailyWorkHours: Double = 12
        let weeklyWorkDays: Int = 7
        
        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds.doubleValue, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
         let expectedResult = ((oneYearInSeconds + sixMonthsInSeconds + twoWeeksInSeconds + fourDaysInSeconds) * NSDecimalNumber(value: 2)) + threeHoursInSeconds
         XCTAssertEqual(result.doubleValue, expectedResult.doubleValue)
    }
    
    // MARK: Year, month, week, day, hours and minutes
     
     func testGetWorkTimeFor1y6m2w4d3h40mWith12hDailyWorkTimeGetsTwiceWorkTimeNeeded() {
        let oneYearInSeconds = NSDecimalNumber(value: 1.yearInSeconds)
        let sixMonthsInSeconds = NSDecimalNumber(value: 6.monthsInSeconds)
        let twoWeeksInSeconds = NSDecimalNumber(value: 2.weeksInSeconds)
        let fourDaysInSeconds = NSDecimalNumber(value: 4.daysInSeconds)
        let threeHoursInSeconds = NSDecimalNumber(value: 3.hoursInSeconds)
        let fourtyMinutesInSeconds = NSDecimalNumber(value: 40.minutesInSeconds)
        
        let priceAsSeconds = (oneYearInSeconds + sixMonthsInSeconds + twoWeeksInSeconds + fourDaysInSeconds + threeHoursInSeconds + fourtyMinutesInSeconds)
        let dailyWorkHours: Double = 12
        let weeklyWorkDays: Int = 7
        
        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds.doubleValue, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
         let expectedResult = ((oneYearInSeconds + sixMonthsInSeconds + twoWeeksInSeconds + fourDaysInSeconds) * NSDecimalNumber(value: 2)) + threeHoursInSeconds + fourtyMinutesInSeconds
         XCTAssertEqual(result.doubleValue, expectedResult.doubleValue)
    }
    
    // MARK: Year, month, week, day, hours, minutes and seconds
     
     func testGetWorkTimeFor1y6m2w4d3h40m55sWith12hDailyWorkTimeGetsTwiceWorkTimeNeeded() {
        let oneYearInSeconds = NSDecimalNumber(value: 1.yearInSeconds)
        let sixMonthsInSeconds = NSDecimalNumber(value: 6.monthsInSeconds)
        let twoWeeksInSeconds = NSDecimalNumber(value: 2.weeksInSeconds)
        let fourDaysInSeconds = NSDecimalNumber(value: 4.daysInSeconds)
        let threeHoursInSeconds = NSDecimalNumber(value: 3.hoursInSeconds)
        let fourtyMinutesInSeconds = NSDecimalNumber(value: 40.minutesInSeconds)
        let fiftyFiveSeconds = NSDecimalNumber(value: 55)
        
        let priceAsSeconds = (oneYearInSeconds + sixMonthsInSeconds + twoWeeksInSeconds + fourDaysInSeconds + threeHoursInSeconds + fourtyMinutesInSeconds + fiftyFiveSeconds)
        let dailyWorkHours: Double = 12
        let weeklyWorkDays: Int = 7
        
        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds.doubleValue, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
         let expectedResult = ((oneYearInSeconds + sixMonthsInSeconds + twoWeeksInSeconds + fourDaysInSeconds) * NSDecimalNumber(value: 2)) + threeHoursInSeconds + fourtyMinutesInSeconds + fiftyFiveSeconds
         XCTAssertEqual(result.doubleValue, expectedResult.doubleValue)
    }
    
    
    // MARK: ---------------
    
//    func testGetWorkTimeFor1Day() {
//        let priceAsSeconds: Double = 8.hoursInSeconds
//        let dailyWorkHours: Double = 8
//        let weeklyWorkDays: Int = 5
//
//        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
//
//        XCTAssertEqual(result.doubleValue, 1.dayInSeconds)
//    }
//
//    func testGetWorkTimeFor2Days() {
//        let priceAsSeconds: Double = 16.hoursInSeconds
//        let dailyWorkHours: Double = 8
//        let weeklyWorkDays: Int = 5
//
//        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
//
//        XCTAssertEqual(result.doubleValue, 2.daysInSeconds)
//    }
//
//    func testGetWorkTimeForHalfDay() {
//        let priceAsSeconds: Double = 4.hoursInSeconds
//        let dailyWorkHours: Double = 8
//        let weeklyWorkDays: Int = 5
//
//        let result = getSUT().getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
//
//        XCTAssertEqual(result.doubleValue, 4.hoursInSeconds)
//    }
//
//    func testGetWorkTimeDescriptionToPay() {
//        let priceAsSeconds: Double = 3.hourInSeconds
//        let dailyWorkHours: Double = 1
//        let weeklyWorkDays: Int = 3
//
//        let result = getSUT().getWorkTimeDescriptionToPay(for: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
//
//        XCTAssertEqual(result, "3 days")
//    }
//
//    func testGetWorkTimeDescriptionToPay2() {
//        let priceAsSeconds: Double = 1.hourInSeconds
//        let dailyWorkHours: Double = 1
//        let weeklyWorkDays: Int = 1
//
//        let result = getSUT().getWorkTimeDescriptionToPay(for: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
//
//        XCTAssertEqual(result, "1 hour")
//    }
//
//    func testGetWorkHoursRoutineFor10HoursReturnsNil() {
//        let priceAsSeconds = NSDecimalNumber(value: 10.hoursInSeconds)
//        let dailyWorkHours: Double = 8
//        let weeklyWorkDays: Int = 5
//
//        let result = getSUT().getWorkRoutineDescriptionToPay(for: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
//
//        XCTAssertNil(result)
//    }
//
//    func testGetWorkHoursRoutineFor48HoursReturnsDailyRoutine() {
//        let priceAsSeconds = NSDecimalNumber(value: 48.hoursInSeconds)
//        let dailyWorkHours: Double = 8
//        let weeklyWorkDays: Int = 5
//
//        let result = getSUT().getWorkRoutineDescriptionToPay(for: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
//
//        XCTAssertNotNil(result)
//        XCTAssertEqual(result?.value, 8)
//        XCTAssertEqual(result?.period, .daily)
//    }
//
//    func testGetWorkHoursRoutineFor2WeeksReturnsWeeklyRoutine() {
//        let priceAsSeconds = NSDecimalNumber(value: 2.weeksInSeconds)
//        let dailyWorkHours: Double = 8
//        let weeklyWorkDays: Int = 5
//
//        let result = getSUT().getWorkRoutineDescriptionToPay(for: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
//
//        XCTAssertNotNil(result)
//        XCTAssertEqual(result?.value, 8*5)
//        XCTAssertEqual(result?.period, .weekly)
//    }


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
