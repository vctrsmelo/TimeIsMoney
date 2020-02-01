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
        
        var priceDiscountingTime = priceAsDecimalSeconds
        
        let oneYearInSeconds = NSDecimalNumber(value: 1.yearInSeconds)
        let oneMonthInSeconds = NSDecimalNumber(value: 1.monthInSeconds)
        let oneWeekInSeconds = NSDecimalNumber(value: 1.weekInSeconds)
        let oneDayInSeconds = NSDecimalNumber(value: 1.dayInSeconds)
        let oneHourInSeconds = NSDecimalNumber(value: 1.hourInSeconds)
        
        let yearsNeeded = (priceDiscountingTime / oneYearInSeconds).floor
        let yearsNeededAsSeconds = yearsNeeded * oneYearInSeconds
        priceDiscountingTime -= yearsNeededAsSeconds

        let monthsNeeded = (priceDiscountingTime / oneMonthInSeconds).floor
        let monthsNeededAsSeconds = monthsNeeded * oneMonthInSeconds
        priceDiscountingTime -= monthsNeededAsSeconds
        
        let weeksNeeded = (priceDiscountingTime / oneWeekInSeconds).floor
        let weeksNeededAsSeconds = weeksNeeded * oneWeekInSeconds
        priceDiscountingTime -= weeksNeededAsSeconds
        
        let daysNeeded = (priceDiscountingTime / oneDayInSeconds).floor
        let daysNeededAsSeconds = daysNeeded * oneDayInSeconds
        priceDiscountingTime -= daysNeededAsSeconds
        
        let hoursNeeded = (priceDiscountingTime / oneHourInSeconds).floor
        let hoursNeededAsSeconds = hoursNeeded * oneHourInSeconds
        priceDiscountingTime -= hoursNeededAsSeconds
    
        
        // Return normalizations
        
        let returnYearsAsSeconds = getNumberOfWorkYearsAsSecondsToWorkAll(yearsNeeded: yearsNeeded, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        let returnMonthsInSeconds = getNumberOfWorkMonthsAsSecondsToWorkAll(monthsNeeded: monthsNeeded, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        let returnWeeksInSeconds = getNumberOfWorkWeeksAsSecondsToWorkAll(weeksNeeded: weeksNeeded, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        let returnDaysInSeconds = getNumberOfWorkDaysAsSecondsToWorkAll(daysNeeded: daysNeeded, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        let returnHoursInSeconds = getNumberOfWorkHoursAsSecondsToWorkAll(hoursNeeded: hoursNeeded, dailyWorkHours: dailyWorkHours, weeklyWorkDays: weeklyWorkDays)
        
        
        return returnYearsAsSeconds + returnMonthsInSeconds + returnWeeksInSeconds + returnDaysInSeconds + returnHoursInSeconds
        
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
    
    private static func getNumberOfWorkMonthsAsSecondsToWorkAll(monthsNeeded: NSDecimalNumber, dailyWorkHours: NSDecimalNumber, weeklyWorkDays: NSDecimalNumber) -> NSDecimalNumber {

        let workdaysInMonth = weeklyWorkDays * WEEKS_IN_MONTH
        let monthInSeconds = NSDecimalNumber(value: 1.monthInSeconds)
        let secondsInHour = NSDecimalNumber(value: 1.hourInSeconds)
            
        let workHoursInMonth = workdaysInMonth * dailyWorkHours
        
        let hoursNeeded = monthsNeeded * (monthInSeconds/secondsInHour)
    
        return (hoursNeeded / workHoursInMonth) * monthInSeconds
    }
    
    private static func getNumberOfWorkWeeksAsSecondsToWorkAll(weeksNeeded: NSDecimalNumber, dailyWorkHours: NSDecimalNumber, weeklyWorkDays: NSDecimalNumber) -> NSDecimalNumber {

        let weekInSeconds = NSDecimalNumber(value: 1.weekInSeconds)
        let hourInSeconds = NSDecimalNumber(value: 1.hourInSeconds)
            
        let workHoursInWeek = weeklyWorkDays * dailyWorkHours
        
        let hoursNeeded = weeksNeeded * (weekInSeconds/hourInSeconds)
    
        return (hoursNeeded / workHoursInWeek) * weekInSeconds
    }
    
    private static func getNumberOfWorkDaysAsSecondsToWorkAll(daysNeeded: NSDecimalNumber, dailyWorkHours: NSDecimalNumber, weeklyWorkDays: NSDecimalNumber) -> NSDecimalNumber {

        let dayInSeconds = NSDecimalNumber(value: 1.dayInSeconds)
        let hourInSeconds = NSDecimalNumber(value: 1.hourInSeconds)
        
        let hoursNeeded = daysNeeded * (dayInSeconds/hourInSeconds)
    
        return (hoursNeeded / dailyWorkHours) * dayInSeconds
    }
    
    private static func getNumberOfWorkHoursAsSecondsToWorkAll(hoursNeeded: NSDecimalNumber, dailyWorkHours: NSDecimalNumber, weeklyWorkDays: NSDecimalNumber) -> NSDecimalNumber {
        return hoursNeeded * NSDecimalNumber(value: 1.hourInSeconds)
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
