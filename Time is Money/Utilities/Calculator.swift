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
}

 enum Calculator {
    
     static func getWorkTimeToPay(for price: Double, user: User) -> Result<TimeInterval, CalculatorError> {
        return getWorkTimeToPay(for: Money(value: price), user: user)

    }
    
     static func getWorkTimeToPay(for price: Money, user: User) -> Result<TimeInterval, CalculatorError> {
        guard price > 0.0 else { return .success(0.0) }
        if case .failure(let error) = isUserDataValid(user) {
            return .failure(error)
        }
        
        var priceDiscountingAlreadyPaidValue = price
        var currentWorkSeconds = NSDecimalNumber(value: 0.0)
        
        var yearsIteration: Int = 0
        // year
        while priceDiscountingAlreadyPaidValue >= user.getSalaryPerYear() {
            yearsIteration += 1
            priceDiscountingAlreadyPaidValue -= user.getSalaryPerYear()
            currentWorkSeconds += user.yearlyWorkSeconds
        }
        
        var monthIteration: Int = 0
        // month
        while priceDiscountingAlreadyPaidValue >= user.getSalaryPerMonth() {
            monthIteration += 1
            priceDiscountingAlreadyPaidValue -= user.getSalaryPerMonth()
            currentWorkSeconds += user.monthlyWorkSeconds
        }
    
        // week
        while priceDiscountingAlreadyPaidValue >= user.getSalaryPerWeek() {
            priceDiscountingAlreadyPaidValue -= user.getSalaryPerWeek()
            currentWorkSeconds += user.weeklyWorkSeconds
        }
        
        // day
        while priceDiscountingAlreadyPaidValue >= user.getSalaryPerDay() {
            priceDiscountingAlreadyPaidValue -= user.getSalaryPerDay()
            currentWorkSeconds += user.dailyWorkSeconds
        }
        
        // hour
        while priceDiscountingAlreadyPaidValue >= user.getSalaryPerHour() {
            priceDiscountingAlreadyPaidValue -= user.getSalaryPerHour()
            currentWorkSeconds += user.hourWorkSeconds
        }
        
        // minute
        while priceDiscountingAlreadyPaidValue >= user.getSalaryPerMinute() {
            priceDiscountingAlreadyPaidValue -= user.getSalaryPerMinute()
            currentWorkSeconds += user.minuteWorkSeconds
        }
        
        // second
        while priceDiscountingAlreadyPaidValue >= user.getSalaryPerSecond() {
            priceDiscountingAlreadyPaidValue -= user.getSalaryPerSecond()
            currentWorkSeconds += user.secondWorkSeconds
        }
        
        return .success(currentWorkSeconds.timeIntervalValue)
    }
    
     static func getMoneyReceivedFromWorkSeconds(workSeconds: TimeInterval, user: User) -> Result<Money, CalculatorError> {
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
