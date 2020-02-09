//
//  AppState.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 07/02/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import SwiftUI

public class AppState: ObservableObject {
    @Published var user = User()
    @Published var avatar = AvatarFactory.male1()
    @Published var workplace = ScenarioFactory.Workplace.office
    @Published var currentPrice = Money(value: 100.0)
    @Published var system = System()
    
    func getCurrentValue() -> Value {
        return Value(money: currentPrice, user: user)
    }
}

typealias User = AppState.User
public extension AppState {
    struct User {
        public var isOnboardingCompleted: Bool = false
        public var monthlySalary: Decimal = 1000
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
}

public extension AppState {
    struct System {
        public var isActive: Bool = false
        public var keyboardHeight: CGFloat = 0
    }
}
