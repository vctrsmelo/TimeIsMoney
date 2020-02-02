//
//  GeneralExtensions.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 07/01/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation

public extension Decimal {
    func asDouble() -> Double {
        return (self as NSDecimalNumber).doubleValue
    }
    
    func asNSNumber() -> NSNumber {
        return (self as NSDecimalNumber)
    }
}

public extension Double {
    func asDecimal() -> Decimal {
        Decimal(self)
    }
    
    func asNSDecimalNumber() -> NSDecimalNumber {
        NSDecimalNumber(value: self)
    }
}

public extension TimeInterval {
    
    static func from(years: TimeInterval = 0.0, months: TimeInterval = 0.0, weeks: TimeInterval = 0.0, days: TimeInterval = 0.0, hours: TimeInterval = 0.0, minutes: TimeInterval = 0.0, seconds: TimeInterval = 0.0) -> Self {
        return years.yearsInSeconds + months.monthsInSeconds + weeks.weeksInSeconds + days.daysInSeconds + hours.hoursInSeconds + minutes.minutesInSeconds + seconds
    }
    
    var minuteInSeconds: Self {
        minutesInSeconds
    }
    
    var hourInSeconds: Self {
        hoursInSeconds
    }
    
    var dayInSeconds: Self {
        daysInSeconds
    }
    
    var weekInSeconds: Self {
        weeksInSeconds
    }
    
    var monthInSeconds: Self {
        monthsInSeconds
    }
    
    var yearInSeconds: Self {
        yearsInSeconds
    }
    
    var minutesInSeconds: Self {
        self * 60
    }
    
    var hoursInSeconds: Self {
        self * 3600
    }
    
    var daysInSeconds: Self {
        self * 86400
    }
    
    var weeksInSeconds: Self {
        self * 604800
    }
    
    var monthsInSeconds: Self {
        (NSDecimalNumber(value: self) * (NSDecimalNumber(value: 604800) * WEEKS_IN_MONTH)).doubleValue
    }
    
    var yearsInSeconds: Self {
        
        let oneYearInSeconds = NSDecimalNumber(value: 1) * (NSDecimalNumber(value: 1) * (NSDecimalNumber(value: 604800) * WEEKS_IN_MONTH) * NSDecimalNumber(value: 12))
        
        return (NSDecimalNumber(value: self) * oneYearInSeconds).doubleValue
    }
    
}
