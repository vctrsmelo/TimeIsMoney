//
//  Flow.swift
//  TimeIsMoneyEngine
//
//  Created by Victor Melo on 11/11/19.
//  Copyright © 2019 Victor Melo. All rights reserved.
//

import Foundation

let WEEKS_IN_MONTH = 4.0
let SECONDS_IN_HOUR = 3600.00

class Flow {
    
    var currentTimeInterval: TimeInterval = 0.0
    
    init() { }
    
    func start(initialValue: Double, salary: Double, weeklyWorkHours: Double, weeklyWorkDays: Int) {

        let secondsWorkingNeeded = Calculator.getTotalSecondsNeededToPay(for: initialValue, salary: salary, weeklyWorkHours: weeklyWorkHours, weeklyWorkDays: weeklyWorkDays)

        self.currentTimeInterval = secondsWorkingNeeded
    }
}

enum Calculator {
    
    static func getTotalSecondsNeededToPay(for value: Double, salary: Double, weeklyWorkHours: Double, weeklyWorkDays: Int) -> TimeInterval {
        
        let dailyWorkHours = weeklyWorkHours / Double(weeklyWorkDays)
        let weeklySalary = salary / WEEKS_IN_MONTH
        let dailySalary = weeklySalary / Double(weeklyWorkDays)
        let salaryPerHour = dailySalary / dailyWorkHours
        
        let hoursWorkingNeeded: TimeInterval = (value/salaryPerHour)
        let secondsWorkingNeeded: TimeInterval = hoursWorkingNeeded * SECONDS_IN_HOUR
        
        return secondsWorkingNeeded
    }
}

struct TimeTextTranslator {
    
}
