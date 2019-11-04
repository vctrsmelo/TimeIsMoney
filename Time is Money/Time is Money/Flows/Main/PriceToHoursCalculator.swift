//
//  PriceToHoursCalculator.swift
//  Time is Money
//
//  Created by Victor Melo on 01/11/19.
//  Copyright © 2019 Victor S Melo. All rights reserved.
//

import Foundation

typealias Price = Double
typealias WorkHours = Double

struct PriceToHoursCalculator {
    
    let weeklyWorkHours: WorkHours
    let monthlySalary: Double
    let weeklyWorkDays: Int
    
    init(weeklyWorkHours: WorkHours, monthlySalary: Double, weeklyWorkDays: Int) {
        self.weeklyWorkHours = weeklyWorkHours
        self.monthlySalary = monthlySalary
        self.weeklyWorkDays = weeklyWorkDays
    }
    
    func getWorkTimeNeededToPay(for price: Price) -> TimeInterval {
        let workSecondsPrice: TimeInterval = price / User.instance.salaryPerSecond
        return workSecondsPrice
    }
    
}
