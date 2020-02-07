////
////  User.swift
////  TimeIsMoneyCore
////
////  Created by Victor Melo on 18/11/19.
////  Copyright © 2019 Victor Melo. All rights reserved.
////
//
//import Foundation
//
//public struct User: Equatable {
//    
//    // MARK: Properties
//    
//    public var isOnboardingCompleted: Bool
//    public var monthlySalary: Decimal
//    public var weeklyWorkHours: Int
//    public var workdays: [Weekday]
//    
//    private var isUnitTesting: Bool
//    
//    // MARK: Initializers
//    
//    public init(isTesting: Bool = false) {
//        self.monthlySalary = 1000.0
//        self.weeklyWorkHours = 40
//        self.workdays = Weekday.weekdays()
//        self.isOnboardingCompleted = false
//        self.isUnitTesting = isTesting
//    }
//
////    public init(monthlySalary: Decimal, weeklyWorkHours: Int, isOnboardingCompleted: Bool, workdays: [Weekday]) {
////        self.monthlySalary = monthlySalary
////        self.weeklyWorkHours = weeklyWorkHours
////        self.isOnboardingCompleted = isOnboardingCompleted
////        self.workdays = workdays
////        isUnitTesting = false
////    }
//    
////    public func getSalaryPerYear() -> Money {
////        NSDecimalNumber(decimal: monthlySalary) * NSDecimalNumber(value: 12)
////    }
////
////    public func getSalaryPerMonth() -> Money {
////        NSDecimalNumber(decimal: monthlySalary)
////    }
////
////    public func getSalaryPerWeek() -> Money {
////        getSalaryPerMonth() / WEEKS_IN_MONTH
////    }
////
////    public func getSalaryPerDay() -> Money {
////        getSalaryPerWeek() / NSDecimalNumber(value: weeklyWorkDays)
////    }
////
////    public func getSalaryPerHour() -> Money {
////        getSalaryPerDay() / dailyWorkHours
////    }
////
////    public func getSalaryPerMinute() -> Money {
////        getSalaryPerHour() / NSDecimalNumber(value: 60)
////    }
////
////    public func getSalaryPerSecond() -> Money {
////        getSalaryPerMinute() / NSDecimalNumber(value: SecondsContainedIn.minute.rawValue)
////    }
////
////    public func getMoneyReceivedFromSeconds(workSeconds: TimeInterval) -> Money {
////        return getSalaryPerSecond() * NSDecimalNumber(value: workSeconds)
////    }
////
////    public func isSelectedHoursValid(_ selectedHours: Int) -> Bool {
////        return (selectedHours < workdays.count || selectedHours > workdays.count * 24)
////    }
////
////    private func syncWorkdaysWithWorkHours() {
////        if weeklyWorkHours < workdays.count {
////            weeklyWorkHours = workdays.count
////        } else if weeklyWorkHours > workdays.count*24 {
////            weeklyWorkHours = workdays.count*24
////        }
////    }
//}
