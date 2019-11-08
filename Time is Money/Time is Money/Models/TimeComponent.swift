//
//  TimeComponent.swift
//  Time is Money
//
//  Created by Victor Melo on 08/11/19.
//  Copyright © 2019 Victor S Melo. All rights reserved.
//

import Foundation

struct TimeComponent {
    let months: Int
    let weeks: Int
    let days: Int
    let hours: Int
    let minutes: Int
    let seconds: Int
    
    static func from(seconds: TimeInterval) -> TimeComponent {
        let data = seconds.getAdjustedTime()
        return TimeComponent(months: data.months, weeks: data.weeks, days: data.days, hours: data.hours, minutes: data.minutes, seconds: data.seconds)
    }
    
    func getDateStringFormatted() -> String {
        
        let workMonth = months
        let workWeek = weeks
        let workDay = days
        let workHour = hours
        let workMinute = minutes
        let workSecond = seconds
        
        var response = ""
        
        if workMinute == 0 && workHour == 0 && workDay == 0 && workWeek == 0 && workMonth == 0 {
            let second = workSecond > 1 ? NSLocalizedString("seconds", comment: "") : NSLocalizedString("second", comment: "")
            response += "\(workSecond) \(second)"
        }
        
        if workMinute > 0 && workDay == 0 {
            
            let minute = workMonth > 1 ? NSLocalizedString("minutes", comment: "") : NSLocalizedString("minute", comment: "")
            response = "\(workMinute) \(minute) \(response)"
        }
        
        if workHour > 0 && workMonth == 0 {
            let hour = workMonth > 1 ? NSLocalizedString("hours", comment: "") : NSLocalizedString("hour", comment: "")
            response = "\(workHour) \(hour) \(response)"
        }
        
        if workDay > 0 {
            let day = workMonth > 1 ? NSLocalizedString("days", comment: "") : NSLocalizedString("day", comment: "")
            response = "\(workDay) \(day) \(response)"
        }
        
        if workWeek > 0 {
            let week = workMonth > 1 ? NSLocalizedString("weeks", comment: "") : NSLocalizedString("week", comment: "")
            response = "\(workWeek) \(week) \(response)"
        }
        
        if workMonth > 0 {
            let month = workMonth > 1 ? NSLocalizedString("months", comment: "") : NSLocalizedString("month", comment: "")
            response = "\(workMonth) \(month) \(response)"
        }
        
        return response
    }
}


private extension TimeInterval {
    
    func getAdjustedTime() -> (months: Int, weeks: Int, days: Int, hours: Int, minutes: Int, seconds: Int) {
        
        var days = workDay
        var hours = workHour
        var minutes = workMinute
        var seconds = workSecond
        var weeks = workWeek
        var months = workMonth
        
        let adjustedSecondsAndExtraMinutes = getAdjustedSecondsAndExtraMinutes(currentSeconds: seconds)
        seconds = adjustedSecondsAndExtraMinutes.seconds
        minutes += adjustedSecondsAndExtraMinutes.extraMinutes
        
        let adjustedMinutesAndExtraHours = getAdjustedMinutesAndExtraHours(currentMinutes: minutes)
        minutes = adjustedMinutesAndExtraHours.minutes
        hours += adjustedMinutesAndExtraHours.extraHours
        
        let adjustedHoursAndExtraDays = getAdjustedHoursAndExtraDays(currentHours: hours)
        hours = adjustedHoursAndExtraDays.hours
        days += adjustedHoursAndExtraDays.extraDays
        
        let adjustedDaysAndExtraWeeks = getAdjustedDaysAndExtraWeeks(currentDays: days)
        days = adjustedDaysAndExtraWeeks.days
        weeks += adjustedDaysAndExtraWeeks.extraWeeks
        
        let adjustedWeeksAndExtraMonths = getAdjustedWeeksAndExtraMonths(currentWeeks: weeks)
        weeks = adjustedWeeksAndExtraMonths.weeks
        months += adjustedWeeksAndExtraMonths.extraMonths
        
        return (months: months, weeks: weeks, days: days, hours: hours, minutes: minutes, seconds: seconds)
    }
    
    private func getAdjustedSecondsAndExtraMinutes(currentSeconds: Int) -> (seconds: Int, extraMinutes: Int) {
        var seconds = currentSeconds
        var extraMinutes = 0
        
        while seconds >= 60 {
            extraMinutes += 1
            seconds -= 60
        }
        
        return (seconds: seconds, extraMinutes: extraMinutes)
    }
    
    private func getAdjustedMinutesAndExtraHours(currentMinutes: Int) -> (minutes: Int, extraHours: Int) {
        var minutes = currentMinutes
        var extraHours = 0
        
        while minutes >= 60 {
            extraHours += 1
            minutes -= 60
        }
        
        return (minutes: minutes, extraHours: extraHours)
    }
    
    private func getAdjustedHoursAndExtraDays(currentHours: Int) -> (hours: Int, extraDays: Int) {
        var hours = currentHours
        var extraDays = 0
        
        while hours >= Int(WorkTimeConverter.numberOfWorkHoursInAWorkDay) {
            extraDays += 1
            hours -= Int(WorkTimeConverter.numberOfWorkHoursInAWorkDay)
        }
        
        return (hours: hours, extraDays: extraDays)
    }
    
    private func getAdjustedDaysAndExtraWeeks(currentDays: Int) -> (days: Int, extraWeeks: Int) {
        var days = currentDays
        var extraWeeks = 0
        
        while days >= Int(WorkTimeConverter.numberOfWorkDaysInAWeek) {
            extraWeeks += 1
            days -= Int(WorkTimeConverter.numberOfWorkDaysInAWeek)
        }
        
        return (days: days, extraWeeks: extraWeeks)
    }
    
    private func getAdjustedWeeksAndExtraMonths(currentWeeks: Int) -> (weeks: Int, extraMonths: Int) {
        var weeks = currentWeeks
        var extraMonths = 0
        
        while weeks >= Int(TimeConverter.numberOfWeeksInAMonth) {
            extraMonths += 1
            weeks -= Int(TimeConverter.numberOfWeeksInAMonth)
        }
        
        return (weeks: weeks, extraMonths: extraMonths)
    }

}
