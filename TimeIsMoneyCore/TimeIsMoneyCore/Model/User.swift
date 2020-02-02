//
//  User.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 18/11/19.
//  Copyright © 2019 Victor Melo. All rights reserved.
//

import Foundation

public class User: ObservableObject {
    
    // MARK: Static Properties
    
    public static var instance = User()
    
    // MARK: Published Properties
    
    @Published public var isOnboardingCompleted: Bool {
        didSet {
            UserDefaults.standard.set(isOnboardingCompleted, forKey: "isOnboardingCompleted")
        }
    }
    
    @Published public var monthlySalary: Decimal {
        didSet {
            guard isUnitTesting == false else { return }
            UserDefaults.standard.set(monthlySalary, forKey: "MonthlySalary")
        }
    }
    
    @Published public var weeklyWorkHours: Int {
        didSet {
            guard isUnitTesting == false else { return }
            syncWorkdaysWithWorkHours()
            UserDefaults.standard.set(weeklyWorkHours, forKey: "WeeklyWorkHours")
        }
    }
    
    @Published public var workdays: [Weekday] {
        didSet {
            guard isUnitTesting == false else { return }
            syncWorkdaysWithWorkHours()
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(workdays) {
                UserDefaults.standard.set(encoded, forKey: "Workdays")
            }
        }
    }
    
    // MARK: Properties
    
    public var weeklyWorkDays: Int {
        return workdays.count
    }
    
    public var dailyWorkHours: NSDecimalNumber {
        return NSDecimalNumber(value: weeklyWorkHours) / NSDecimalNumber(value: workdays.count)
    }
    
    public var yearlyWorkSeconds: NSDecimalNumber {
        return monthlyWorkSeconds * NSDecimalNumber(value: 12)
    }
    
    public var monthlyWorkSeconds: NSDecimalNumber {
        return weeklyWorkSeconds * WEEKS_IN_MONTH
    }
    
    public var weeklyWorkSeconds: NSDecimalNumber {
        return NSDecimalNumber(value: weeklyWorkHours) * NSDecimalNumber(value: SecondsContainedIn.hour.asDouble())
    }
    
    public var dailyWorkSeconds: NSDecimalNumber {
        return dailyWorkHours * NSDecimalNumber(value: 1.hourInSeconds)
    }
    
    public var hourWorkSeconds: NSDecimalNumber {
        NSDecimalNumber(value: 3600)
    }
    
    public var minuteWorkSeconds: NSDecimalNumber {
        NSDecimalNumber(value: 60)
    }
    
    public var secondWorkSeconds: NSDecimalNumber {
        NSDecimalNumber(value: 60)
    }
    
    
    public var sortedWorkdays: [Weekday] {
        var sortedWorkdays = Weekday.all()
        sortedWorkdays.removeAll {
            !self.workdays.contains($0)
        }
        
        return sortedWorkdays
    }
    
    private var isUnitTesting: Bool
    
    public init(testing: Bool = false) {
        self.isUnitTesting = testing
        
        if testing {
            self.monthlySalary = 1000.0
            self.weeklyWorkHours = 7
            self.workdays = Weekday.all()
            self.isOnboardingCompleted = false
            
        } else {
            self.monthlySalary = UserDefaults.standard.double(forKey: "MonthlySalary").asDecimal()
            
            if UserDefaults.standard.isKeyPresentInUserDefaults(key: "WeeklyWorkHours") {
                self.weeklyWorkHours = UserDefaults.standard.integer(forKey: "WeeklyWorkHours")
            } else {
                self.weeklyWorkHours = 40
            }
            self.isOnboardingCompleted = UserDefaults.standard.bool(forKey: "isOnboardingCompleted")
            
            self.workdays = [Weekday]()
            
            if UserDefaults.standard.isKeyPresentInUserDefaults(key: "Workdays") {
                guard let workdaysData = UserDefaults.standard.data(forKey: "Workdays") else { return }
                guard let decoded = try? JSONDecoder().decode([Weekday].self, from: workdaysData) else { return }
                self.workdays = decoded
            } else {
                self.workdays = [.monday, .tuesday, .wednesday, .thursday, .friday]
            }
            
        }

    }
    
    public func getWorkTimeToPay(for moneyValue: Double) -> TimeInterval {
        getWorkTimeToPay(for: Money(value: moneyValue))
    }
    
    public func getWorkTimeToPay(for moneyValue: Money) -> TimeInterval {
        (moneyValue / getSalaryPerSecond()).timeIntervalValue
    }
    
    public func getSalaryPerYear() -> Money {
        NSDecimalNumber(decimal: monthlySalary) * NSDecimalNumber(value: 12)
    }
    
    public func getSalaryPerMonth() -> Money {
        NSDecimalNumber(decimal: monthlySalary)
    }
    
    public func getSalaryPerWeek() -> Money {
        getSalaryPerMonth() / WEEKS_IN_MONTH
    }
    
    public func getSalaryPerDay() -> Money {
        getSalaryPerWeek() / NSDecimalNumber(value: weeklyWorkDays)
    }
    
    public func getSalaryPerHour() -> Money {
        getSalaryPerDay() / dailyWorkHours
    }
    
    public func getSalaryPerMinute() -> Money {
        getSalaryPerHour() / NSDecimalNumber(value: 60)
    }

    public func getSalaryPerSecond() -> Money {
        getSalaryPerMinute() / NSDecimalNumber(value: SecondsContainedIn.minute.rawValue)
    }
    
    public func getMoneyReceivedFromSeconds(workSeconds: TimeInterval) -> Money {
        return getSalaryPerSecond() * NSDecimalNumber(value: workSeconds)
    }
    
    public func isSelectedHoursValid(_ selectedHours: Int) -> Bool {
        return (selectedHours < workdays.count || selectedHours > workdays.count * 24)
    }
    
    private func syncWorkdaysWithWorkHours() {
        if weeklyWorkHours < workdays.count {
            weeklyWorkHours = workdays.count
        } else if weeklyWorkHours > workdays.count*24 {
            weeklyWorkHours = workdays.count*24
        }
    }
}

extension UserDefaults {
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
