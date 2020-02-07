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
    @Published var system = System()
}

public extension AppState {
    struct User {
        public var isOnboardingCompleted: Bool = false
        public var monthlySalary: Decimal = 1000
        public var weeklyWorkHours: Int = 40
        public var workdays: [Weekday] = Weekday.weekdays()
    }
}

public extension AppState {
    struct System {
        public var isActive: Bool = false
        public var keyboardHeight: CGFloat = 0
    }
}
