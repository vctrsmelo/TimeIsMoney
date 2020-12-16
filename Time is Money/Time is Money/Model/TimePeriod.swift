//
//  TimePeriod.swift
//  Time is Money
//
//  Created by Victor Melo on 07/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation

protocol TimePeriod {
    var value: NSDecimalNumber { get }
    func asSecond() -> NSDecimalNumber
    func asMinute() -> NSDecimalNumber
    func asHour() -> NSDecimalNumber
    func asDay() -> NSDecimalNumber
    func asWeekOfMonth() -> NSDecimalNumber
    func asMonth() -> NSDecimalNumber
    func asYear() -> NSDecimalNumber
}

struct SecondTimePeriod: TimePeriod {
    
    var value: NSDecimalNumber
    
    func asSecond() -> NSDecimalNumber {
        value
    }
    
    func asMinute() -> NSDecimalNumber {
        value / NSDecimalNumber(value: 60)
    }
    
    func asHour() -> NSDecimalNumber {
        value / NSDecimalNumber(value: 3600)
    }
    
    func asDay() -> NSDecimalNumber {
        value / NSDecimalNumber(value: 86400)
    }
    
    func asWeekOfMonth() -> NSDecimalNumber {
        value / NSDecimalNumber(value: 604800)
    }
    
    func asMonth() -> NSDecimalNumber {
        value / (NSDecimalNumber(value: 604800) * WEEKS_IN_MONTH)
    }
    
    func asYear() -> NSDecimalNumber {
        value / (NSDecimalNumber(value: 7257600) * WEEKS_IN_MONTH)
    }
    
}

struct MinuteTimePeriod: TimePeriod {
    
    var value: NSDecimalNumber
    
    func asSecond() -> NSDecimalNumber {
        value * NSDecimalNumber(value: 60)
    }
    
    func asMinute() -> NSDecimalNumber {
        value
    }
    
    func asHour() -> NSDecimalNumber {
        value / NSDecimalNumber(value: 60)
    }
    
    func asDay() -> NSDecimalNumber {
        value / NSDecimalNumber(value: 1440)
    }
    
    func asWeekOfMonth() -> NSDecimalNumber {
        value / NSDecimalNumber(value: 10080)
    }
    
    func asMonth() -> NSDecimalNumber {
        value / (NSDecimalNumber(value: 10080) * WEEKS_IN_MONTH)
    }
    
    func asYear() -> NSDecimalNumber {
        value / (NSDecimalNumber(value: 120960) * WEEKS_IN_MONTH)
    }
    
}

struct HourTimePeriod: TimePeriod {
    
    var value: NSDecimalNumber
    
    func asSecond() -> NSDecimalNumber {
        value * NSDecimalNumber(value: 3600)
    }
    
    func asMinute() -> NSDecimalNumber {
        value * NSDecimalNumber(value: 60)
    }
    
    func asHour() -> NSDecimalNumber {
        value
    }
    
    func asDay() -> NSDecimalNumber {
        value / NSDecimalNumber(value: 24)
    }
    
    func asWeekOfMonth() -> NSDecimalNumber {
        value / NSDecimalNumber(value: 168)
    }
    
    func asMonth() -> NSDecimalNumber {
        value / (NSDecimalNumber(value: 168) * WEEKS_IN_MONTH)
    }
    
    func asYear() -> NSDecimalNumber {
        value / (NSDecimalNumber(value: 2016) * WEEKS_IN_MONTH)
    }
}

struct DayTimePeriod: TimePeriod {
    
    var value: NSDecimalNumber
    
    func asSecond() -> NSDecimalNumber {
        value * NSDecimalNumber(value: 86400)
    }
    
    func asMinute() -> NSDecimalNumber {
        value * NSDecimalNumber(value: 1440)
    }
    
    func asHour() -> NSDecimalNumber {
        value * NSDecimalNumber(value: 24)
    }
    
    func asDay() -> NSDecimalNumber {
        value
    }
    
    func asWeekOfMonth() -> NSDecimalNumber {
        value / NSDecimalNumber(value: 7)
    }
    
    func asMonth() -> NSDecimalNumber {
        value / (NSDecimalNumber(value: 7) * WEEKS_IN_MONTH)
    }
    
    func asYear() -> NSDecimalNumber {
        value / (NSDecimalNumber(value: 84) * WEEKS_IN_MONTH)
    }
    
    
}

struct WeekTimePeriod: TimePeriod {
    
    var value: NSDecimalNumber
    
    func asSecond() -> NSDecimalNumber {
        value * NSDecimalNumber(value: 604800)
    }
    
    func asMinute() -> NSDecimalNumber {
        value * NSDecimalNumber(value: 10080)
    }
    
    func asHour() -> NSDecimalNumber {
        value * NSDecimalNumber(value: 168)
    }
    
    func asDay() -> NSDecimalNumber {
        value * NSDecimalNumber(value: 7)
    }
    
    func asWeekOfMonth() -> NSDecimalNumber {
        value
    }
    
    func asMonth() -> NSDecimalNumber {
        value / WEEKS_IN_MONTH
    }
    
    func asYear() -> NSDecimalNumber {
        value / (NSDecimalNumber(value: 12) * WEEKS_IN_MONTH)
    }
    
    
}

struct MonthTimePeriod: TimePeriod {
    
    var value: NSDecimalNumber
    
    func asSecond() -> NSDecimalNumber {
        value * NSDecimalNumber(value: 604800) * WEEKS_IN_MONTH
    }
    
    func asMinute() -> NSDecimalNumber {
        value * NSDecimalNumber(value: 10080) * WEEKS_IN_MONTH
    }
    
    func asHour() -> NSDecimalNumber {
        value * NSDecimalNumber(value: 168) * WEEKS_IN_MONTH
    }
    
    func asDay() -> NSDecimalNumber {
        value * NSDecimalNumber(value: 7) * WEEKS_IN_MONTH
    }
    
    func asWeekOfMonth() -> NSDecimalNumber {
        value * WEEKS_IN_MONTH
    }
    
    func asMonth() -> NSDecimalNumber {
        value
    }
    
    func asYear() -> NSDecimalNumber {
        value * NSDecimalNumber(value: 12)
    }
    
    
}

struct YearTimePeriod: TimePeriod {
    
    var value: NSDecimalNumber
    
    func asSecond() -> NSDecimalNumber {
        value * NSDecimalNumber(value: 7257600) * WEEKS_IN_MONTH
    }
    
    func asMinute() -> NSDecimalNumber {
        value * NSDecimalNumber(value: 120960) * WEEKS_IN_MONTH
    }
    
    func asHour() -> NSDecimalNumber {
        value * NSDecimalNumber(value: 2016) * WEEKS_IN_MONTH
    }
    
    func asDay() -> NSDecimalNumber {
        value * NSDecimalNumber(value: 84) * WEEKS_IN_MONTH
    }
    
    func asWeekOfMonth() -> NSDecimalNumber {
        value * NSDecimalNumber(value: 12) * WEEKS_IN_MONTH
    }
    
    func asMonth() -> NSDecimalNumber {
        value * NSDecimalNumber(value: 12)
    }
    
    func asYear() -> NSDecimalNumber {
        value
    }
    
}


