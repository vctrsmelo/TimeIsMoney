import Foundation

extension TimeInterval {
    
    init(months: Int, weeks: Int, days: Int, hours: Int, minutes: Int) {
        let minutesAsSeconds = minutes * Int(TimeConverter.numberOfSecondsInAMinute)
        let hoursAsSeconds = hours * Int(TimeConverter.numberOfSecondsInAnHour)
        let daysAsSeconds = days * Int(TimeConverter.numberOfSecondsInADay)
        let weekAsSeconds = weeks * Int(TimeConverter.numberOfSecondsInAWeek)
        let monthAsSeconds = months * Int(TimeConverter.numberOfSecondsInAMonth)
    
        let totalSeconds = monthAsSeconds + weekAsSeconds + daysAsSeconds + hoursAsSeconds + minutesAsSeconds
        
        self.init(totalSeconds)
    }
    
    var month: Int {
        return Int((self/TimeConverter.numberOfSecondsInAMonth).truncatingRemainder(dividingBy: TimeConverter.numberOfSecondsInAMonth))
    }
    
    var week: Int {
        return Int((self/TimeConverter.numberOfSecondsInAWeek).truncatingRemainder(dividingBy: TimeConverter.numberOfWeeksInAMonth))
    }
    
    var day: Int {
        return Int((self/TimeConverter.numberOfSecondsInADay).truncatingRemainder(dividingBy: TimeConverter.numberOfDaysInAWeek))
    }
    
    var hour: Int {
        return Int((self/TimeConverter.numberOfSecondsInAnHour).truncatingRemainder(dividingBy: TimeConverter.numberOfHoursInADay))
    }
    
    var minute: Int {
        return Int((self/TimeConverter.numberOfSecondsInAMinute).truncatingRemainder(dividingBy: TimeConverter.numberOfSecondsInAMinute))
    }
    
    var second: Int {
        return Int(truncatingRemainder(dividingBy: 60))
    }
}

extension TimeInterval {
    
    var workMonth: Int {
        return Int((self/WorkTimeConverter.numberOfWorkSecondsInAMonth).truncatingRemainder(dividingBy: WorkTimeConverter.numberOfWorkSecondsInAMonth))
    }
    
    var workWeek: Int {
        return Int((self/WorkTimeConverter.numberOfWorkSecondsInAWeek).truncatingRemainder(dividingBy: TimeConverter.numberOfWeeksInAMonth))
    }
    
    var workDay: Int {
        return Int((self/WorkTimeConverter.numberOfWorkSecondsInAWorkDay).truncatingRemainder(dividingBy: WorkTimeConverter.numberOfWorkDaysInAWeek))
    }
    
    var workHour: Int {
        return Int((self/TimeConverter.numberOfSecondsInAnHour).truncatingRemainder(dividingBy: WorkTimeConverter.numberOfWorkHoursInAWorkDay))
    }
    
    var workMinute: Int {
        return Int((self/TimeConverter.numberOfSecondsInAMinute).truncatingRemainder(dividingBy: TimeConverter.numberOfMinutesInAnHour))
    }

    var workSecond: Int {
        return second
    }
    
}
