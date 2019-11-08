//
//  TimeConversion.swift
//  Time is Money
//
//  Created by Victor Melo on 01/11/19.
//  Copyright © 2019 Victor S Melo. All rights reserved.
//

enum TimeConverter {
    static let numberOfSecondsInAMinute: Double = 60
    static let numberOfMinutesInAnHour: Double = 60
    static let numberOfHoursInADay: Double = 24
    static let numberOfDaysInAWeek: Double = 7
    static let numberOfWeeksInAMonth: Double = 4
    
    static let numberOfSecondsInAnHour: Double = numberOfSecondsInAMinute * numberOfMinutesInAnHour
    static let numberOfSecondsInADay: Double = numberOfSecondsInAnHour * numberOfHoursInADay
    static let numberOfSecondsInAWeek: Double = numberOfSecondsInADay * numberOfDaysInAWeek
    static let numberOfSecondsInAMonth: Double = numberOfSecondsInAWeek * numberOfWeeksInAMonth
}

enum WorkTimeConverter {
    static var numberOfWorkHoursInAWorkDay: Double { return User.instance.dailyWorkHours }
    static var numberOfWorkDaysInAWeek: Double { return Double(User.instance.weeklyWorkDays) }
    
    static let numberOfWorkSecondsInAWorkDay: Double = TimeConverter.numberOfSecondsInAnHour * numberOfWorkHoursInAWorkDay
    static let numberOfWorkSecondsInAWeek: Double = TimeConverter.numberOfSecondsInADay * numberOfWorkDaysInAWeek
    static let numberOfWorkSecondsInAMonth: Double = TimeConverter.numberOfWeeksInAMonth * numberOfWorkSecondsInAWeek
}
