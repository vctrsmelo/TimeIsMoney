//
//  User.swift
//  Time is Money
//
//  Created by Victor Melo on 10/06/21.
//  Copyright © 2021 Victor S Melo. All rights reserved.
//

import Foundation
import SwiftUI

struct User {
    
    public var isOnboardingCompleted: Bool = false
    public var monthlySalary: NSDecimalNumber = 1000

    public var weeklyWorkHours: Int = 40 {
        didSet {
            syncWorkdaysWithWorkHours()
        }
    }

    public var workdays: [Weekday] = Weekday.weekdays() {
        didSet {
            syncWorkdaysWithWorkHours()
        }
    }
    
    func isSelectedHoursValid(_ selectedHours: Int) -> Bool {
        return (selectedHours < workdays.count || selectedHours > workdays.count * 24)
    }

    private mutating func syncWorkdaysWithWorkHours() {
        if weeklyWorkHours < workdays.count {
            weeklyWorkHours = workdays.count
        } else if weeklyWorkHours > workdays.count*24 {
            weeklyWorkHours = workdays.count*24
        }
    }
}
