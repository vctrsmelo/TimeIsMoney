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
        return getWorkTimeToPay(for: Money(value: price), user: user)

    }
    
    public static func getWorkTimeToPay(for price: Money, user: User) -> Result<WorkTimeSeconds, CalculatorError> {
        guard price > 0.0 else { return .success(0.0) }
        if case .failure(let error) = isUserDataValid(user) {
            return .failure(error)
        }
        
        let dailyWorkHours = NSDecimalNumber(value: user.weeklyWorkHours) / NSDecimalNumber(value: user.workdays.count)
        
        let weeklySalary = user.monthlySalary.asMoney() / WEEKS_IN_MONTH
        let dailySalary = weeklySalary / NSDecimalNumber(value: user.workdays.count)
        let salaryPerHour = dailySalary / dailyWorkHours
        
        let hoursWorkingNeeded = (price/salaryPerHour)
        let secondsWorkingNeeded = hoursWorkingNeeded * SECONDS_IN_HOUR
        
        return .success(secondsWorkingNeeded.timeIntervalValue)
    }
    
    public static func getMoneyReceivedFromWorkSeconds(workSeconds: TimeInterval, user: User) -> Result<Money, CalculatorError> {
        guard workSeconds > 0.0 else { return .success(0.0) }
        if case .failure(let error) = isUserDataValid(user) {
            return .failure(error)
        }
        
        let salaryPerSecond = user.getSalaryPerSecond()
        let receivedMoney = salaryPerSecond * NSDecimalNumber(value: workSeconds)
        
        return .success(receivedMoney)
    }
    
    private static func isUserDataValid(_ user: User) -> Result<Void, CalculatorError> {
        guard isWorkingAtLeastOneDayPerWeek(user) else { return .failure(CalculatorError.undefinedWeeklyWorkDays)}
        guard isWorkingAtLeast1HourPerWeek(user) else { return .failure(CalculatorError.undefinedWeeklyWorkHours)}
        guard hasMonthlyIncome(user) else { return .failure(CalculatorError.undefinedSalary) }
        
        return .success(())
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
