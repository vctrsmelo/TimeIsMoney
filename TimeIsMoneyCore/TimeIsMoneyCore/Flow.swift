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

public typealias WorkTime = TimeInterval

public enum CalculatorError: Error {
    case undefinedWeeklyWorkDays
    case undefinedWeeklyWorkHours
    case undefinedSalary
}

public class Flow {

    public let user: User
    
    public init(monthlySalary: Double, weeklyWorkHours: Double, weeklyWorkDays: Int) {
        user = User(monthlySalary: monthlySalary, weeklyWorkHours: weeklyWorkHours, weeklyWorkDays: weeklyWorkDays)
    }
    
    public func getTimeNeededToPay(for price: Double) -> Result<WorkTime, CalculatorError> {
        return Calculator.getWorkTimeToPay(for: price, user: user)
    }

    public func getExpensivityIndex(price: Double, maxIndex: Int) -> Int {
        let maxPrice = user.monthlySalary
        let currentLevel = min(Int(floor(price * Double(maxIndex) / maxPrice)), maxIndex)
        
        return currentLevel
    }
}

public enum Calculator {
    public static func getWorkTimeToPay(for price: Double, user: User) -> Result<WorkTime, CalculatorError> {
        
        guard price > 0.0 else { return .success(0.0) }
        
        guard user.weeklyWorkDays > 0 else { return .failure(CalculatorError.undefinedWeeklyWorkDays)}
        
        guard user.weeklyWorkHours > 0 else { return .failure(CalculatorError.undefinedWeeklyWorkHours)}
        
        guard user.monthlySalary > 0 else { return
            .failure(CalculatorError.undefinedSalary)
        }
        
        let dailyWorkHours = user.weeklyWorkHours / Double(user.weeklyWorkDays)
        let weeklySalary = ceil(user.monthlySalary / WEEKS_IN_MONTH)
        let dailySalary = weeklySalary / Double(user.weeklyWorkDays)
        let salaryPerHour = dailySalary / dailyWorkHours
        
        let hoursWorkingNeeded: WorkTime = (price/salaryPerHour)
        let secondsWorkingNeeded: WorkTime = hoursWorkingNeeded * SECONDS_IN_HOUR
        
        return .success(secondsWorkingNeeded)
    }
}

public class TimeTextTranslator {
    
    private static let formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second]
        return formatter
    }()
    
    public static func getUnstoppedWorkTimeDescription(from fullWorkTime: WorkTime) -> String {
        return formatter.string(from: fullWorkTime)!
    }
    
    public static func getUserWorkTimeDescription(from fullWorkTime: WorkTime, dailyWorkHours: Double, weeklyWorkDays: Int) -> String {
        
        // needed because otherwise would consider 24h as work daily routine.
        let workTimeNormalizingDailyWork =  24.0 * (fullWorkTime / dailyWorkHours)
        
        // needed because otherwise would consider 7 days per week as work weekly routine.
        let workTimeNormalizingWeekWork = 7 * workTimeNormalizingDailyWork / Double(weeklyWorkDays)
        
        return formatter.string(from: workTimeNormalizingWeekWork)!
        
    }
    
}
