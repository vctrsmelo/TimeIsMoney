//
//  Flow.swift
//  TimeIsMoneyEngine
//
//  Created by Victor Melo on 11/11/19.
//  Copyright © 2019 Victor Melo. All rights reserved.
//

import Foundation

let WEEKS_IN_MONTH = 4.429531 // ~30 days per month
let SECONDS_IN_HOUR = 3600.00

public typealias WorkTimeSeconds = TimeInterval

public enum CalculatorError: Error {
    case undefinedWeeklyWorkDays
    case undefinedWeeklyWorkHours
    case undefinedSalary
}

public class Flow {

    public let user: User
    
    public init(user: User = User.instance) {
        self.user = user
    }
    
    public func getTimeNeededToPay(for price: Double) -> Result<WorkTimeSeconds, CalculatorError> {
        return Calculator.getWorkTimeToPay(for: price, user: user)
    }

    public func getExpensivityIndex(price: Double, maxIndex: Int) -> Int {
        let maxPrice = max(1,user.monthlySalary)
        let currentLevel = min(Int(round(price * Double(maxIndex) / maxPrice.asDouble())), maxIndex)
        
        return currentLevel
    }
}

public enum Calculator {
    public static func getWorkTimeToPay(for price: Double, user: User) -> Result<WorkTimeSeconds, CalculatorError> {
        
        guard price > 0.0 else { return .success(0.0) }
        guard workAtLeastOneDayPerWeek(user) else { return .failure(CalculatorError.undefinedWeeklyWorkDays)}
        guard workAtLeast1HourPerWeek(user) else { return .failure(CalculatorError.undefinedWeeklyWorkHours)}
        guard hasMonthlyIncome(user) else { return .failure(CalculatorError.undefinedSalary) }
        
        let dailyWorkHours = Double(user.weeklyWorkHours) / Double(user.workdays.count)
        
        let weeklySalary = ceil(user.monthlySalary.asDouble() / WEEKS_IN_MONTH)
        let dailySalary = weeklySalary / Double(user.workdays.count)
        let salaryPerHour = dailySalary / dailyWorkHours
        
        let hoursWorkingNeeded: WorkTimeSeconds = (price/salaryPerHour)
        let secondsWorkingNeeded: WorkTimeSeconds = hoursWorkingNeeded * SECONDS_IN_HOUR
        
        return .success(secondsWorkingNeeded)
    }
    
    private static func workAtLeastOneDayPerWeek(_ user: User) -> Bool {
        user.workdays.count > 0
    }
    
    private static func workAtLeast1HourPerWeek(_ user: User) -> Bool {
        user.weeklyWorkHours > 0
    }
    
    private static func hasMonthlyIncome(_ user: User) -> Bool {
        user.monthlySalary > 0
    }
}

public class TimeTextTranslator {
    
    public static var allowedUnits: NSCalendar.Unit {
        get {
            return formatter.allowedUnits
        }
        set {
            formatter.allowedUnits = newValue
        }
    }
    
    private static let formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second]
        return formatter
    }()
    
    public static func getUnstoppedWorkTimeDescription(from fullWorkTime: WorkTimeSeconds) -> String {
        return formatter.string(from: fullWorkTime)!
    }
    
    public static func getUserWorkTimeDescription(from priceAsSeconds: WorkTimeSeconds, dailyWorkHours: Double, weeklyWorkDays: Int) -> String {
        
        guard dailyWorkHours > 0 else {
            return "You need to increase your work hours"
        }
        
        adjustFormatterAllowedUnits(for: priceAsSeconds)
        
        if priceAsSeconds <= dailyWorkHours * (SecondsIn.hour.asDouble()) {
            return formatter.string(from: priceAsSeconds)!
        }
        
        // needed because otherwise would consider 24h as work daily routine.
        let workTimeNormalizingDailyWork =  24.0 * (priceAsSeconds / dailyWorkHours)
        
        if priceAsSeconds <= dailyWorkHours * Double(weeklyWorkDays) * (SecondsIn.hour.asDouble()) {
            return formatter.string(from: workTimeNormalizingDailyWork)!
        }
        
        // needed because otherwise would consider 7 days per week as work weekly routine.
        let workTimeNormalizingWeekWork = 7 * workTimeNormalizingDailyWork / Double(weeklyWorkDays)
    
        
        return formatter.string(from: workTimeNormalizingWeekWork)!
        
    }
    
    private static func adjustFormatterAllowedUnits(for seconds: WorkTimeSeconds) {
        formatter.allowedUnits = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second]
        
        if isLongerThanAnHour(seconds) {
            formatter.allowedUnits.remove(.second)
        }
        
        if isLongerThanADay(seconds) {
            formatter.allowedUnits.remove(.minute)
        }
        
        if isLongerThanAWeek(seconds) {
            formatter.allowedUnits.remove(.hour)
        }
        
        if isLongerThanAMonth(seconds) {
            formatter.allowedUnits.remove(.day)
        }
        
        if isLongerThanAYear(seconds) {
            formatter.allowedUnits.remove(.weekOfMonth)
        }
    }
    
    private static func isLongerThanAnHour(_ seconds: WorkTimeSeconds) -> Bool {
        return (seconds >= SecondsIn.hour.asDouble())
    }
    
    private static func isLongerThanADay(_ seconds: WorkTimeSeconds) -> Bool {
        return (seconds >= SecondsIn.day.asDouble())
    }
    
    private static func isLongerThanAWeek(_ seconds: WorkTimeSeconds) -> Bool {
        return (seconds >= SecondsIn.week.asDouble())
    }
    
    private static func isLongerThanAMonth(_ seconds: WorkTimeSeconds) -> Bool {
        return (seconds >= SecondsIn.month.asDouble())
    }
    
    private static func isLongerThanAYear(_ seconds: WorkTimeSeconds) -> Bool {
        return (seconds >= SecondsIn.year.asDouble())
    }
    
}

enum SecondsIn: Int {
    case year = 31104000
    case month = 2592000
    case week = 604800
    case day = 86400
    case hour = 3600
    case minute = 60
    
    func asDouble() -> Double {
        return Double(self.rawValue)
    }
}
