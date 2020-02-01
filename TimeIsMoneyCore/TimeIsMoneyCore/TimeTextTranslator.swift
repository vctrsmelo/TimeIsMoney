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
        formatter.allowedUnits = [NSCalendar.Unit.era, .year, .month, .weekOfMonth, .day, .hour, .minute, .second]
        
        let calendar = Calendar.current
        formatter.calendar = calendar
        
        return formatter
    }()
    
    public static func getUnstoppedWorkTimeDescription(from fullWorkTime: WorkTimeSeconds) -> String {
        return formatter.string(from: fullWorkTime)!
    }
    
    public static func getWorkTimeDescriptionToPay(for priceAsSeconds: WorkTimeSeconds, user: User) -> String {
        guard user.dailyWorkHours > 0 else {
            return "You need to increase your work hours"
        }
        
        let normalizedWorkTime = getNormalizedWorkTimeFrom(priceAsSeconds: NSDecimalNumber(value: priceAsSeconds), dailyWorkHours: user.dailyWorkHours, weeklyWorkDays: NSDecimalNumber(value: user.workdays.count), user: user)
        
        adjustFormatterAllowedUnits(for: normalizedWorkTime, user: user)
        
        let formattedDescription = formatter.string(from: normalizedWorkTime) ?? "¯\\_(ツ)_/¯"

        return formattedDescription
    }
    //price as seconds: 43055,04132 //user salary: 1000 // weekly work hours: 10h // workdays: 3 //semanas resultado esperado: 1,3288593
    public static func getNormalizedWorkTimeFrom(priceAsSeconds: NSDecimalNumber, dailyWorkHours: NSDecimalNumber, weeklyWorkDays: NSDecimalNumber, user: User) -> NSDecimalNumber {
        
            var priceSecondsDiscountingTime = priceAsSeconds
            
            let oneWorkYearInSeconds = user.yearlyWorkSeconds
            let oneWorkMonthInSeconds = user.monthlyWorkSeconds
            let oneWorkWeekInSeconds = user.weeklyWorkSeconds
            let oneWorkDayInSeconds = user.dailyWorkSeconds
        
            let oneYearInSeconds = NSDecimalNumber(value: 1.yearInSeconds)
            let oneMonthInSeconds = NSDecimalNumber(value: 1.monthInSeconds)
            let oneWeekInSeconds = NSDecimalNumber(value: 1.weekInSeconds)
            let oneDayInSeconds = NSDecimalNumber(value: 1.dayInSeconds)
            let oneHourInSeconds = NSDecimalNumber(value: 1.hourInSeconds)
            let oneMinuteInSeconds = NSDecimalNumber(value: 1.minuteInSeconds)
        
            let yearsNeeded = (priceSecondsDiscountingTime / oneWorkYearInSeconds).floor
            let yearsNeededAsSeconds = yearsNeeded * oneYearInSeconds
            priceSecondsDiscountingTime -= yearsNeeded * oneWorkYearInSeconds

            let monthsNeeded = (priceSecondsDiscountingTime / oneWorkMonthInSeconds).floor
            let monthsNeededAsSeconds = monthsNeeded * oneMonthInSeconds
            priceSecondsDiscountingTime -= monthsNeeded * oneWorkMonthInSeconds
            
            let weeksNeeded = (priceSecondsDiscountingTime / oneWorkWeekInSeconds).floor
            let weeksNeededAsSeconds = weeksNeeded * oneWeekInSeconds
            priceSecondsDiscountingTime -= weeksNeeded * oneWorkWeekInSeconds
            
            let daysNeeded = (priceSecondsDiscountingTime / oneWorkDayInSeconds).floor
            let daysNeededAsSeconds = daysNeeded * oneDayInSeconds
            priceSecondsDiscountingTime -= daysNeeded * oneWorkDayInSeconds
            
            let hoursNeeded = (priceSecondsDiscountingTime / oneHourInSeconds).floor
            let hoursNeededAsSeconds = hoursNeeded * oneHourInSeconds
            priceSecondsDiscountingTime -= hoursNeeded * oneHourInSeconds
        
            let minutesNeeded = (priceSecondsDiscountingTime / oneMinuteInSeconds).floor
            let minutesNeededAsSeconds = minutesNeeded * oneMinuteInSeconds
            priceSecondsDiscountingTime -= minutesNeeded * oneMinuteInSeconds
            
            let neededSeconds = priceSecondsDiscountingTime
            
            let returnValue = yearsNeededAsSeconds + monthsNeededAsSeconds + weeksNeededAsSeconds + daysNeededAsSeconds + hoursNeededAsSeconds + minutesNeededAsSeconds + neededSeconds
            
            return returnValue
    }
    
    private static func hoursNeededAreExactlyANumberOfDays(_ hoursNeeded: NSDecimalNumber, dailyWorkHours: NSDecimalNumber) -> Bool {
        hoursNeeded % dailyWorkHours == 0
    }
    
    public static func getWorkRoutineDescriptionToPay(for price: NSDecimalNumber, dailyWorkHours: NSDecimalNumber, weeklyWorkDays: Int) -> Routine? {
        guard price >= NSDecimalNumber(value: 1.dayInSeconds) else { return nil }
        
        if price < NSDecimalNumber(value: 1.weekInSeconds) {
            return Routine(value: dailyWorkHours, period: .daily)
        } else {
            let weeklyWorkHours = dailyWorkHours * NSDecimalNumber(value: weeklyWorkDays)
            return Routine(value: weeklyWorkHours, period: .weekly)
        }
    }
    
    private static func adjustFormatterAllowedUnits(for seconds: NSDecimalNumber, user: User) {
        formatter.allowedUnits = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second]
        
        if isLongerThanADay(seconds) {
            formatter.allowedUnits.remove(.second)
        }
        
        if isLongerThanAWeek(seconds) {
            formatter.allowedUnits.remove(.minute)
        }
        
        if isLongerThanAMonth(seconds) {
            formatter.allowedUnits.remove(.hour)
        }
        
        if isLongerThanAYear(seconds) {
            formatter.allowedUnits.remove(.day)
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
    
    private static func isLongerThanAWorkDay(_ seconds: NSDecimalNumber, dailyWorkSeconds: NSDecimalNumber) -> Bool {
        return (seconds >= dailyWorkSeconds)
    }
    
    private static func isLongerThanAWorkWeek(_ seconds: NSDecimalNumber, weekyWorkSeconds: NSDecimalNumber) -> Bool {
        return (seconds >= weekyWorkSeconds)
    }
    
    private static func isLongerThanAWorkMonth(_ seconds: NSDecimalNumber, monthlyWorkSeconds: NSDecimalNumber) -> Bool {
        return (seconds >= monthlyWorkSeconds)
    }
    
    private static func isLongerThanAWorkYear(_ seconds: NSDecimalNumber, yearlyWorkSeconds: NSDecimalNumber) -> Bool {
        return (seconds >= yearlyWorkSeconds)
    }
}
