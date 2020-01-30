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
    
    public var dailyWorkHours: Double {
        return Double(weeklyWorkHours) / Double(workdays.count)
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
            self.weeklyWorkHours = UserDefaults.standard.integer(forKey: "WeeklyWorkHours")
            self.isOnboardingCompleted = UserDefaults.standard.bool(forKey: "isOnboardingCompleted")
            
            self.workdays = [Weekday]()
            
            guard let workdaysData = UserDefaults.standard.data(forKey: "Workdays") else { return }
            guard let decoded = try? JSONDecoder().decode([Weekday].self, from: workdaysData) else { return }
            
            self.workdays = decoded
        }

    }
    
    private func syncWorkdaysWithWorkHours() {
        if weeklyWorkHours < workdays.count {
            weeklyWorkHours = workdays.count
        } else if weeklyWorkHours > workdays.count*24 {
            weeklyWorkHours = workdays.count*24
        }
    }
    
    public func isSelectedHoursValid(_ selectedHours: Int) -> Bool {
        return (selectedHours < workdays.count || selectedHours > workdays.count * 24)
    }
}
