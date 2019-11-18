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

typealias WorkTime = TimeInterval

enum CalculatorError: Error {
    case undefinedWeeklyWorkDays
    case undefinedWeeklyWorkHours
    case undefinedSalary
}

struct User {
    let monthlySalary: Double
    let weeklyWorkHours: Double
    let weeklyWorkDays: Int
}

class Flow {
    
    let user: User
    
    init(monthlySalary: Double, weeklyWorkHours: Double, weeklyWorkDays: Int) {
        user = User(monthlySalary: monthlySalary, weeklyWorkHours: weeklyWorkHours, weeklyWorkDays: weeklyWorkDays)
    }
    
    func getTimeNeededToPay(for price: Double) -> Result<WorkTime, CalculatorError> {
        return Calculator.getWorkTimeToPay(for: price, user: user)
    }
}

enum Calculator {
    
    static func getWorkTimeToPay(for price: Double, user: User) -> Result<WorkTime, CalculatorError> {
        
        guard price > 0.0 else { return .success(0.0) }
        
        guard user.weeklyWorkDays > 0 else { return .failure(CalculatorError.undefinedWeeklyWorkDays)}
        
        guard user.weeklyWorkHours > 0 else { return .failure(CalculatorError.undefinedWeeklyWorkHours)}
        
        guard user.monthlySalary > 0 else { return
            .failure(CalculatorError.undefinedSalary)
        }
        
        let dailyWorkHours = user.weeklyWorkHours / Double(user.weeklyWorkDays)
        let weeklySalary = user.monthlySalary / WEEKS_IN_MONTH
        let dailySalary = weeklySalary / Double(user.weeklyWorkDays)
        let salaryPerHour = dailySalary / dailyWorkHours
        
        let hoursWorkingNeeded: WorkTime = (price/salaryPerHour)
        let secondsWorkingNeeded: WorkTime = hoursWorkingNeeded * SECONDS_IN_HOUR
        
        return .success(secondsWorkingNeeded)
    }
}

class TimeTextTranslator {
    
    static let formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .weekOfMonth, .hour, .minute, .second]
        return formatter
    }()
    
    static func getDescription(from workTime: WorkTime) -> String {
        return formatter.string(from: workTime)!
    }
    
}
