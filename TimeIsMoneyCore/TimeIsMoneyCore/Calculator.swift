//
//  Calculator.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 29/01/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation

public enum Calculator {
    
    public static func getWorkTimeToPay(for price: Double, user: User) -> Result<WorkTimeSeconds, CalculatorError> {
        
        guard price > 0.0 else { return .success(0.0) }
        guard isWorkingAtLeastOneDayPerWeek(user) else { return .failure(CalculatorError.undefinedWeeklyWorkDays)}
        guard isWorkingAtLeast1HourPerWeek(user) else { return .failure(CalculatorError.undefinedWeeklyWorkHours)}
        guard hasMonthlyIncome(user) else { return .failure(CalculatorError.undefinedSalary) }
        
        let dailyWorkHours = Double(user.weeklyWorkHours) / Double(user.workdays.count)
        
        let weeklySalary = ceil(user.monthlySalary.asDouble() / WEEKS_IN_MONTH)
        let dailySalary = weeklySalary / Double(user.workdays.count)
        let salaryPerHour = dailySalary / dailyWorkHours
        
        let hoursWorkingNeeded: WorkTimeSeconds = (price/salaryPerHour)
        let secondsWorkingNeeded: WorkTimeSeconds = hoursWorkingNeeded * SECONDS_IN_HOUR
        
        return .success(secondsWorkingNeeded)
    }
    
    private static func isWorkingAtLeastOneDayPerWeek(_ user: User) -> Bool {
        user.workdays.count > 0
    }
    
    private static func isWorkingAtLeast1HourPerWeek(_ user: User) -> Bool {
        user.weeklyWorkHours > 0
    }
    
    private static func hasMonthlyIncome(_ user: User) -> Bool {
        user.monthlySalary > 0
    }
}
