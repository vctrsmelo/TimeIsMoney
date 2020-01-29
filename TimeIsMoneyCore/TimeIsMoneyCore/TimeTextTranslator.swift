//
//  TimeTextTranslator.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 29/01/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation

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
    
    public static func getWorkTimeDescriptionToPay(for priceAsSeconds: WorkTimeSeconds, dailyWorkHours: Double, weeklyWorkDays: Int) -> String {
        
        guard dailyWorkHours > 0 else {
            return "You need to increase your work hours"
        }
        
        adjustFormatterAllowedUnits(for: priceAsSeconds)
        
        if priceAsSeconds <= dailyWorkHours * (SecondsContainedIn.hour.asDouble()) {
            return formatter.string(from: priceAsSeconds)!
        }
        
        // needed because otherwise would consider 24h as work daily routine.
        let workTimeNormalizingDailyWork =  24.0 * (priceAsSeconds / dailyWorkHours)
        
        if priceAsSeconds <= dailyWorkHours * Double(weeklyWorkDays) * (SecondsContainedIn.hour.asDouble()) {
            return formatter.string(from: workTimeNormalizingDailyWork)!
        }
        
        // needed because otherwise would consider 7 days per week as work weekly routine.
        let workTimeNormalizingWeekWork = 7 * workTimeNormalizingDailyWork / Double(weeklyWorkDays)
    
        return formatter.string(from: workTimeNormalizingWeekWork)!
        
    }
    
    public static func getWorkRoutineDescriptionToPay(for price: WorkTimeSeconds, dailyWorkHours: Double, weeklyWorkDays: Int) -> Routine? {
        guard price >= 1.day else { return nil }
        
        if price < 1.week {
            return Routine(value: dailyWorkHours, period: .daily)
        } else {
            let weeklyWorkHours = dailyWorkHours * Double(weeklyWorkDays)
            return Routine(value: weeklyWorkHours, period: .weekly)
        }
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
        return (seconds >= SecondsContainedIn.hour.asDouble())
    }
    
    private static func isLongerThanADay(_ seconds: WorkTimeSeconds) -> Bool {
        return (seconds >= SecondsContainedIn.day.asDouble())
    }
    
    private static func isLongerThanAWeek(_ seconds: WorkTimeSeconds) -> Bool {
        return (seconds >= SecondsContainedIn.week.asDouble())
    }
    
    private static func isLongerThanAMonth(_ seconds: WorkTimeSeconds) -> Bool {
        return (seconds >= SecondsContainedIn.month.asDouble())
    }
    
    private static func isLongerThanAYear(_ seconds: WorkTimeSeconds) -> Bool {
        return (seconds >= SecondsContainedIn.year.asDouble())
    }
    
}
