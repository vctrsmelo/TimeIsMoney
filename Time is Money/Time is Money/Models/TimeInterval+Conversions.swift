import Foundation

extension TimeInterval {
    
    init(months: Int, weeks: Int, days: Int, hours: Int, minutes: Int) {
        let minutesAsSeconds = minutes * Int(TimeUnit.secondsInMinute)
        let hoursAsSeconds = hours * Int(TimeUnit.secondsInHour)
        let daysAsSeconds = days * Int(TimeUnit.secondsInDay)
        let weekAsSeconds = weeks * Int(TimeUnit.secondsInWeek)
        let monthAsSeconds = months * Int(TimeUnit.secondsInMonth)
    
        let totalSeconds = monthAsSeconds + weekAsSeconds + daysAsSeconds + hoursAsSeconds + minutesAsSeconds
        
        self.init(totalSeconds)
    }
    
    var month: Int {
        return Int((self/TimeUnit.secondsInMonth).truncatingRemainder(dividingBy: TimeUnit.secondsInMonth))
    }
    
    var week: Int {
        return Int((self/TimeUnit.secondsInWeek).truncatingRemainder(dividingBy: TimeUnit.weeksInMonth))
    }
    
    var day: Int {
        return Int((self/TimeUnit.secondsInDay).truncatingRemainder(dividingBy: TimeUnit.daysInWeek))
    }
    
    var hour: Int {
        return Int((self/TimeUnit.secondsInHour).truncatingRemainder(dividingBy: TimeUnit.hoursInDay))
    }
    
    var minute: Int {
        return Int((self/TimeUnit.secondsInMinute).truncatingRemainder(dividingBy: TimeUnit.secondsInMinute))
    }
    
    var second: Int {
        return Int(truncatingRemainder(dividingBy: 60))
    }
}

extension TimeInterval {
    
    var workMonth: Int {
        return Int((self/TimeUnit.workSecondsInMonth).truncatingRemainder(dividingBy: TimeUnit.workSecondsInMonth))
    }
    
    var workWeek: Int {
        return Int((self/TimeUnit.workSecondsInWeek).truncatingRemainder(dividingBy: TimeUnit.workWeeksInMonth))
    }
    
    var workDay: Int {
        return Int((self/TimeUnit.workSecondsInDay).truncatingRemainder(dividingBy: TimeUnit.workDaysInWeek))
    }
    
    var workHour: Int {
        return Int((self/TimeUnit.workSecondsInHour).truncatingRemainder(dividingBy: TimeUnit.workHoursInDay))
    }
    
    var workMinute: Int {
        return Int((self/TimeUnit.workSecondsInMinute).truncatingRemainder(dividingBy: TimeUnit.workMinutesInHour))
    }

    var workSecond: Int {
        return second
    }
    
}


extension TimeInterval {
    func dateFormatted() -> String {
        
        let values = getAdjustedTime()
        
        let workMonth = values.months
        let workWeek = values.weeks
        let workDay = values.days
        let workHour = values.hours
        let workMinute = values.minutes
        let workSecond = values.seconds
        
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
    
    private func getAdjustedTime() -> (months: Int, weeks: Int, days: Int, hours: Int, minutes: Int, seconds: Int) {
        
        var seconds = workSecond
        var minutes = workMinute
        var hours = workHour
        var days = workDay
        var weeks = workWeek
        var months = workMonth
        
        while seconds >= 60 {
            minutes += 1
            seconds -= 60
        }
        
        while minutes >= 60 {
            hours += 1
            minutes -= 60
        }
        
        while hours >= Int(TimeUnit.workHoursInDay) {
            days += 1
            hours -= Int(TimeUnit.workHoursInDay)
        }
        
        while days >= Int(TimeUnit.workDaysInWeek) {
            weeks += 1
            days -= Int(TimeUnit.workDaysInWeek)
        }
        
        while weeks >= Int(TimeUnit.workWeeksInMonth) {
            months += 1
            weeks -= Int(TimeUnit.workWeeksInMonth)
        }
        
        return (months: months, weeks: weeks, days: days, hours: hours, minutes: minutes, seconds: seconds)
    }
}
