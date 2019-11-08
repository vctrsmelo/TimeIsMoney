//
//  User.swift
//  Time is Money
//
//  Created by Victor Melo on 01/11/19.
//  Copyright © 2019 Victor S Melo. All rights reserved.
//

import Foundation

class User {
    
    static let instance = User()
    
    var weeklyWorkHours: Double = 44
    var monthlySalary: Double = 6600
    var weeklyWorkDays: Int = 5
    
    init() {
        
    }
    
    // MARK: - Timestamp salary
    
    var salaryPerSecond: Double {
        let secondSalary = salaryPerMinute/TimeConverter.numberOfSecondsInAMinute
        return secondSalary
    }
    
    var salaryPerMinute: Double {
        let minuteSalary = salaryPerHour / TimeConverter.numberOfMinutesInAnHour
        return minuteSalary
    }
    
    var salaryPerHour: Double {
        let hourSalary = salaryPerDay / self.dailyWorkHours
        return hourSalary
    }
    
    var salaryPerDay: Double {
        let dailySalary = salaryPerWeek/Double(weeklyWorkDays)
        return dailySalary
    }
    
    var salaryPerWeek: Double {
        let weeklySalary = monthlySalary / TimeConverter.numberOfWeeksInAMonth
        
        return weeklySalary
    }
    
    // MARK: - Timestamp work hours
    
    var dailyWorkHours: Double {
        let dailyWorkHours = weeklyWorkHours/Double(weeklyWorkDays)
        return dailyWorkHours
    }
    
    func getExpensivityIndex(price: Double, maxIndex: Int) -> Int {
        let maxPrice = self.monthlySalary
        let currentLevel = min(Int(floor(price * Double(maxIndex) / maxPrice)), maxIndex)
        
        return currentLevel
    }
}
