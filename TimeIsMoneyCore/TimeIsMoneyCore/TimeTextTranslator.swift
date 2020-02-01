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
        
        let normalizedWorkTime = getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        adjustFormatterAllowedUnits(for: normalizedWorkTime)
        return formatter.string(from: normalizedWorkTime.timeIntervalValue) ?? "¯\\_(ツ)_/¯"
        
    }

    public static func getNormalizedWorkTimeFrom(priceAsSeconds: WorkTimeSeconds, dailyWorkHours: Double, weeklyWorkDays: Int) -> NSDecimalNumber {
        getNormalizedWorkTimeFrom(priceAsDecimalSeconds: NSDecimalNumber(value: priceAsSeconds), dailyWorkHours: NSDecimalNumber(value: dailyWorkHours), weeklyWorkDays: NSDecimalNumber(value: weeklyWorkDays))
    }
    
    public static func getNormalizedWorkTimeFrom(priceAsDecimalSeconds: NSDecimalNumber, dailyWorkHours: NSDecimalNumber, weeklyWorkDays: NSDecimalNumber) -> NSDecimalNumber {
        
        let yearsNeeded = (priceAsDecimalSeconds / NSDecimalNumber(value: 1.yearInSeconds)).floor
//        let yearsNeededAsSeconds = yearsNeeded * NSDecimalNumber(value: 1.yearInSeconds)

        let returnYearsAsSeconds = getNumberOfWorkYearsAsSecondsToWorkAll(yearsNeeded: yearsNeeded, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        return returnYearsAsSeconds
        
//        let monthsNeeded = ((priceAsDecimalSeconds - yearsNeeded) / NSDecimalNumber(value: 1.monthInSeconds)).floor
        
        
        // ------
        
//        let hoursNeeded = (priceAsDecimalSeconds / NSDecimalNumber(value: 1.hourInSeconds)).floor
//
//        let hoursNeededAsSeconds = hoursNeeded * NSDecimalNumber(value: 1.hourInSeconds)
//        let minutesNeeded = ((priceAsDecimalSeconds - hoursNeededAsSeconds) / NSDecimalNumber(value: 1.minuteInSeconds)).floor
//
//        let minutesNeededAsSeconds = minutesNeeded * NSDecimalNumber(value: 1.minuteInSeconds)
//        let secondsNeeded = (priceAsDecimalSeconds - hoursNeededAsSeconds - minutesNeededAsSeconds)
//
//        // Normalize
//
//        let returnHoursAsSeconds: NSDecimalNumber
//        if hoursNeededAreExactlyANumberOfDays(hoursNeeded, dailyWorkHours: dailyWorkHours) {
//            returnHoursAsSeconds = getNumberOfWorkDaysAsSecondsToWorkAll(hoursNeeded: hoursNeeded, dailyWorkHours: dailyWorkHours)
//        } else {
//            returnHoursAsSeconds = hoursNeeded * NSDecimalNumber(value: 1.hourInSeconds)
//        }
//
//        return returnHoursAsSeconds
//
    }
    
    private static func hoursNeededAreExactlyANumberOfDays(_ hoursNeeded: NSDecimalNumber, dailyWorkHours: NSDecimalNumber) -> Bool {
        hoursNeeded % dailyWorkHours == 0
    }
    
    private static func getNumberOfWorkYearsAsSecondsToWorkAll(yearsNeeded: NSDecimalNumber, dailyWorkHours: NSDecimalNumber, weeklyWorkDays: NSDecimalNumber) -> NSDecimalNumber {

        let monthsInYear = NSDecimalNumber(value: 12)
        let workdaysInMonth = weeklyWorkDays * WEEKS_IN_MONTH
        
        // DTA = numero de dias de trabalho no ano
        let workdaysInYear = workdaysInMonth * monthsInYear
            
        // HTA = numero de horas de trabalho no ano
        let workHoursInYear = workdaysInYear * dailyWorkHours
        
        let hoursNeeded = yearsNeeded * (NSDecimalNumber(value: 1.yearInSeconds)/NSDecimalNumber(value: 3600))
        
        // (hoursNeeded / HTA) * NSDecimalNumber(value: 1.yearInSeconds)
        let yearsNeededResponse = (hoursNeeded / workHoursInYear)
        
        return yearsNeededResponse * NSDecimalNumber(value: 1.yearInSeconds)
    }
    
    private static func getNumberOfWorkDaysAsSecondsToWorkAll(hoursNeeded: NSDecimalNumber, dailyWorkHours: NSDecimalNumber) -> NSDecimalNumber {
        (hoursNeeded / dailyWorkHours) * NSDecimalNumber(value: 1.dayInSeconds)
    }
    
    public static func getWorkRoutineDescriptionToPay(for price: NSDecimalNumber, dailyWorkHours: Double, weeklyWorkDays: Int) -> Routine? {
        guard price >= NSDecimalNumber(value: 1.dayInSeconds) else { return nil }
        
        if price < NSDecimalNumber(value: 1.weekInSeconds) {
            return Routine(value: dailyWorkHours, period: .daily)
        } else {
            let weeklyWorkHours = dailyWorkHours * Double(weeklyWorkDays)
            return Routine(value: weeklyWorkHours, period: .weekly)
        }
    }
    
    private static func adjustFormatterAllowedUnits(for seconds: NSDecimalNumber) {
        formatter.allowedUnits = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second]
        
        if isLongerThanAnHour(seconds) {
            formatter.allowedUnits.remove(.second)
            formatter.allowedUnits.remove(.minute)
        }
        
        if isLongerThanADay(seconds) {
            formatter.allowedUnits.remove(.hour)
        }
        
        if isLongerThanAMonth(seconds) {
            formatter.allowedUnits.remove(.day)
        }
        
        if isLongerThanAYear(seconds) {
            formatter.allowedUnits.remove(.weekOfMonth)
        }
    }
    
    private static func isLongerThanAnHour(_ seconds: NSDecimalNumber) -> Bool {
        return (seconds >= SecondsContainedIn.hour.asNSDecimalNumber())
    }
    
    private static func isLongerThanADay(_ seconds: NSDecimalNumber) -> Bool {
        return (seconds >= SecondsContainedIn.day.asNSDecimalNumber())
    }
    
    private static func isLongerThanAWeek(_ seconds: NSDecimalNumber) -> Bool {
        return (seconds >= SecondsContainedIn.week.asNSDecimalNumber())
    }
    
    private static func isLongerThanAMonth(_ seconds: NSDecimalNumber) -> Bool {
        return (seconds >= SecondsContainedIn.month.asNSDecimalNumber())
    }
    
    private static func isLongerThanAYear(_ seconds: NSDecimalNumber) -> Bool {
        return (seconds >= SecondsContainedIn.year.asNSDecimalNumber())
    }
    
}
