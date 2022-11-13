//
//  TimeTextTranslator.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 29/01/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation

class TimeTextTranslator {
    
    static var allowedUnits: NSCalendar.Unit {
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
    
    static func getUnstoppedWorkTimeDescription(from fullWorkTime: TimeInterval) -> String {
        return formatter.string(from: fullWorkTime)!
    }
    
    static func getWorkTimeDescriptionToPay(for priceAsSeconds: NSDecimalNumber, user: User) -> String {
        guard user.dailyWorkHours > 0.00000 && user.monthlySalary > 0.00000 else {
            return R.string.localizable.foreverIGuess😮()
        }
        
        let normalizedWorkTime = getNormalizedWorkTimeFrom(priceAsSeconds: priceAsSeconds, user: user)
        
        adjustFormatterAllowedUnits(for: normalizedWorkTime, user: user)
        
        let formattedDescription = formatter.string(from: normalizedWorkTime) ?? "¯\\_(ツ)_/¯"

        return formattedDescription
    }

    static func getNormalizedWorkTimeFrom(priceAsSeconds: NSDecimalNumber, user: User) -> DateComponents {
        guard user.weeklyWorkHours > 0 else { return DateComponents() }
    
        var components = DateComponents(year: 0, month: 0, day: 0, hour: 0, minute: 0, second: 0)
        var priceSecondsDiscountingTime = priceAsSeconds
        
        let oneWorkYearInSeconds = user.yearlyWorkSeconds
        let oneWorkMonthInSeconds = user.monthlyWorkSeconds
        let oneWorkWeekInSeconds = user.weeklyWorkSeconds
        let oneWorkDayInSeconds = user.dailyWorkSeconds
        
        let oneHourInSeconds = NSDecimalNumber(value: 1.hourInSeconds)
        let oneMinuteInSeconds = NSDecimalNumber(value: 1.minuteInSeconds)
    
        let yearsNeeded = (priceSecondsDiscountingTime / oneWorkYearInSeconds).floor
        components.year = yearsNeeded.intValue
        priceSecondsDiscountingTime -= yearsNeeded * oneWorkYearInSeconds

        let monthsNeeded = (priceSecondsDiscountingTime / oneWorkMonthInSeconds).floor
        components.month = monthsNeeded.intValue
        priceSecondsDiscountingTime -= monthsNeeded * oneWorkMonthInSeconds
        
        let weeksNeeded = (priceSecondsDiscountingTime / oneWorkWeekInSeconds).floor
        components.day = (components.day ?? 0) + (weeksNeeded * 7).intValue
        priceSecondsDiscountingTime -= weeksNeeded * oneWorkWeekInSeconds
        
        let daysNeeded = (priceSecondsDiscountingTime / oneWorkDayInSeconds).floor
        components.day = (components.day ?? 0) + daysNeeded.intValue
        priceSecondsDiscountingTime -= daysNeeded * oneWorkDayInSeconds
        
        let hoursNeeded = (priceSecondsDiscountingTime / oneHourInSeconds).floor
        components.hour = hoursNeeded.intValue
        priceSecondsDiscountingTime -= hoursNeeded * oneHourInSeconds
    
        let minutesNeeded = (priceSecondsDiscountingTime / oneMinuteInSeconds).floor
        components.minute = minutesNeeded.intValue
        priceSecondsDiscountingTime -= minutesNeeded * oneMinuteInSeconds
        
        components.second = priceSecondsDiscountingTime.intValue
        
        return components
    }
    
    private static func hoursNeededAreExactlyANumberOfDays(_ hoursNeeded: NSDecimalNumber, dailyWorkHours: NSDecimalNumber) -> Bool {
        hoursNeeded % dailyWorkHours == 0
    }
    
    static func getWorkRoutineDescriptionToPay(for priceComponents: DateComponents, dailyWorkHours: NSDecimalNumber, weeklyWorkDays: Int) -> WorkRoutine? {
        guard (priceComponents.day ?? 0) > 1 else { return nil }
        
        let isLessThanAWeek = (priceComponents.day ?? 0) < 7
        if isLessThanAWeek {
            return WorkRoutine(value: dailyWorkHours, period: .daily)
        } else {
            let weeklyWorkHours = dailyWorkHours * NSDecimalNumber(value: weeklyWorkDays)
            return WorkRoutine(value: weeklyWorkHours, period: .weekly)
        }
    }
    
    private static func adjustFormatterAllowedUnits(for components: DateComponents, user: User) {
        formatter.allowedUnits = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second]
        
        if let day = components.day, day > 0 {
            formatter.allowedUnits.remove(.second)
        }
        
        if let day = components.day, day > 7 {
            formatter.allowedUnits.remove(.minute)
        }
        
        if let month = components.month, month > 0 {
            formatter.allowedUnits.remove(.hour)
        }
        
        if let year = components.year, year > 0 {
            formatter.allowedUnits.remove(.day)
        }
    }
    
    private static func isLongerThanAnHour(_ seconds: NSDecimalNumber) -> Bool {
        seconds >= 1.hourInSeconds.asNSDecimalNumber()
    }
    
    private static func isLongerThanADay(_ seconds: NSDecimalNumber) -> Bool {
        seconds >= 1.dayInSeconds.asNSDecimalNumber()
    }
    
    private static func isLongerThanAWeek(_ seconds: NSDecimalNumber) -> Bool {
        seconds >= 1.weekInSeconds.asNSDecimalNumber()
    }
    
    private static func isLongerThanAMonth(_ seconds: NSDecimalNumber) -> Bool {
        seconds >= 1.monthInSeconds.asNSDecimalNumber()
    }
    
    private static func isLongerThanAYear(_ seconds: NSDecimalNumber) -> Bool {
        seconds >= 1.yearInSeconds.asNSDecimalNumber()
    }
    
    private static func isLongerThanAWorkDay(_ seconds: NSDecimalNumber, dailyWorkSeconds: NSDecimalNumber) -> Bool {
        seconds >= dailyWorkSeconds
    }
    
    private static func isLongerThanAWorkWeek(_ seconds: NSDecimalNumber, weekyWorkSeconds: NSDecimalNumber) -> Bool {
        seconds >= weekyWorkSeconds
    }
    
    private static func isLongerThanAWorkMonth(_ seconds: NSDecimalNumber, monthlyWorkSeconds: NSDecimalNumber) -> Bool {
        seconds >= monthlyWorkSeconds
    }
    
    private static func isLongerThanAWorkYear(_ seconds: NSDecimalNumber, yearlyWorkSeconds: NSDecimalNumber) -> Bool {
        seconds >= yearlyWorkSeconds
    }
}
