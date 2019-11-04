//
//  TimeConversion.swift
//  Time is Money
//
//  Created by Victor Melo on 01/11/19.
//  Copyright © 2019 Victor S Melo. All rights reserved.
//

enum TimeUnit {
    static let secondsInMinute: Double = 60
    static let minutesInHour: Double = 60
    static let hoursInDay: Double = 24
    static let daysInWeek: Double = 7
    static let weeksInMonth: Double = 4
    
    static let secondsInHour: Double = secondsInMinute * minutesInHour
    static let secondsInDay: Double = secondsInHour * hoursInDay
    static let secondsInWeek: Double = secondsInDay * daysInWeek
    static let secondsInMonth: Double = secondsInWeek * weeksInMonth
    
    static let workSecondsInMinute: Double = secondsInMinute
    static let workMinutesInHour: Double = minutesInHour
    static var workHoursInDay: Double { return User.instance.dailyWorkHours }
    static var workDaysInWeek: Double { return Double(User.instance.weeklyWorkDays) }
    static let workWeeksInMonth: Double = weeksInMonth
    
    static let workSecondsInHour: Double = TimeUnit.workSecondsInMinute * workMinutesInHour
    static let workSecondsInDay: Double = workSecondsInHour * workHoursInDay
    static let workSecondsInWeek: Double = workSecondsInDay * workDaysInWeek
    static let workSecondsInMonth: Double = workSecondsInWeek * workWeeksInMonth
}
