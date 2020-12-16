//
//  User+WorkTime.swift
//  Time is Money
//
//  Created by Victor Melo on 07/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation

extension User {
    
    var weeklyWorkDays: NSDecimalNumber {
        NSDecimalNumber(value: workdays.count)
    }
    
    var dailyWorkHours: NSDecimalNumber {
        guard weeklyWorkDays > 0 else { return NSDecimalNumber(value: 0) }
        return NSDecimalNumber(value: weeklyWorkHours) / weeklyWorkDays
    }
    
    public var yearlyWorkSeconds: NSDecimalNumber {
        monthlyWorkSeconds * NSDecimalNumber(value: 12)
    }
    
    public var monthlyWorkSeconds: NSDecimalNumber {
        weeklyWorkSeconds * WEEKS_IN_MONTH
    }
    
    public var weeklyWorkSeconds: NSDecimalNumber {
        NSDecimalNumber(value: weeklyWorkHours) * NSDecimalNumber(value: SecondsContainedIn.hour.asDouble())
    }
    
    public var dailyWorkSeconds: NSDecimalNumber {
        dailyWorkHours * NSDecimalNumber(value: 1.hourInSeconds)
    }
    
    public var hourWorkSeconds: NSDecimalNumber {
        NSDecimalNumber(value: 3600)
    }
    
    public var minuteWorkSeconds: NSDecimalNumber {
        NSDecimalNumber(value: 60)
    }
    
    public var secondWorkSeconds: NSDecimalNumber {
        NSDecimalNumber(value: 1)
    }
}
