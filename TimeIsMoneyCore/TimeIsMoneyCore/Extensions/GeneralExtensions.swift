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
}

public extension TimeInterval {
    
    static func from(years: TimeInterval = 0.0, months: TimeInterval = 0.0, weeks: TimeInterval = 0.0, days: TimeInterval = 0.0, hours: TimeInterval = 0.0, minutes: TimeInterval = 0.0, seconds: TimeInterval = 0.0) -> Self {
        return years.years + months.months + weeks.weeks + days.days + hours.hours + minutes.minutes + seconds
    }
    
    var minute: Self {
        minutes
    }
    
    var hour: Self {
        hours
    }
    
    var day: Self {
        days
    }
    
    var week: Self {
        weeks
    }
    
    var month: Self {
        months
    }
    
    var year: Self {
        years
    }
    
    var minutes: Self {
        self * 60
    }
    
    var hours: Self {
        self * 3600
    }
    
    var days: Self {
        self * hours * 24
    }
    
    var weeks: Self {
        self * days * 7
    }
    
    var months: Self {
        self * weeks * WEEKS_IN_MONTH.asDouble()
    }
    
    var years: Self {
        self * months * 12
    }
    
}
