//
//  Calculator.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 29/01/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation

enum CalculatorError: Error {
    case undefinedWeeklyWorkDays
    case undefinedWeeklyWorkHours
    case undefinedSalary
    case undefinedPrice
}

enum Calculator {
    
    static func getWorkTimeToPay(for price: Double?, user: User) -> Result<NSDecimalNumber, CalculatorError> {
        guard let price = price else {
            return .failure(CalculatorError.undefinedPrice)
        }
        
        return getWorkTimeToPay(for: Currency(value: price), user: user)
        
    }
    
    static func getWorkTimeToPay(for price: Currency, user: User) -> Result<NSDecimalNumber, CalculatorError> {
        guard price > 0.0 else { return .success(0.0) }
        guard user.workdays.count > 0 else { return .failure(.undefinedWeeklyWorkDays) }
        guard user.monthlySalary > 0.0 else { return .failure(.undefinedSalary) }
        if case .failure(let error) = isUserDataValid(user) {
            return .failure(error)
        }
        
        var priceDiscountingAlreadyPaidValue = price
        var currentWorkSeconds = NSDecimalNumber(value: 0.0)
        
        let workYearsNeeded = (priceDiscountingAlreadyPaidValue / user.getSalaryPerYear()).floor
        priceDiscountingAlreadyPaidValue -= user.getSalaryPerYear() * workYearsNeeded
        currentWorkSeconds += user.yearlyWorkSeconds * workYearsNeeded
        
        let workMonthsNeeded = (priceDiscountingAlreadyPaidValue / user.getSalaryPerMonth()).floor
        priceDiscountingAlreadyPaidValue -= user.getSalaryPerMonth() * workMonthsNeeded
        currentWorkSeconds += user.monthlyWorkSeconds * workMonthsNeeded
        
        let workWeeksNeeded = (priceDiscountingAlreadyPaidValue / user.getSalaryPerWeek()).floor
        priceDiscountingAlreadyPaidValue -= user.getSalaryPerWeek() * workWeeksNeeded
        currentWorkSeconds += user.weeklyWorkSeconds * workWeeksNeeded
        
        let workDaysNeeded = (priceDiscountingAlreadyPaidValue / user.getSalaryPerDay()).floor
        priceDiscountingAlreadyPaidValue -= user.getSalaryPerDay() * workDaysNeeded
        currentWorkSeconds += user.dailyWorkSeconds * workDaysNeeded
        
        let workHoursNeeded = (priceDiscountingAlreadyPaidValue / user.getSalaryPerHour()).floor
        priceDiscountingAlreadyPaidValue -= user.getSalaryPerHour() * workHoursNeeded
        currentWorkSeconds += user.hourWorkSeconds * workHoursNeeded
        
        let workMinutesNeeded = (priceDiscountingAlreadyPaidValue / user.getSalaryPerMinute()).floor
        priceDiscountingAlreadyPaidValue -= user.getSalaryPerMinute() * workMinutesNeeded
        currentWorkSeconds += user.minuteWorkSeconds * workMinutesNeeded
        
        let workSecondsNeeded = (priceDiscountingAlreadyPaidValue / user.getSalaryPerSecond()).floor
        priceDiscountingAlreadyPaidValue -= user.getSalaryPerSecond() * workSecondsNeeded
        currentWorkSeconds += user.secondWorkSeconds * workSecondsNeeded
        
        return .success(currentWorkSeconds)
    }
    
    static func getMoneyReceivedFromWorkSeconds(workSeconds: TimeInterval, user: User) -> Result<Currency, CalculatorError> {
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
