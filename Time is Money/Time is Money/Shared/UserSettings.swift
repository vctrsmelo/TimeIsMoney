//
//  UserSettings.swift
//  Time is Money
//
//  Created by Victor Melo on 05/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation

class UserSettings: ObservableObject {
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    @Published var monthlyIncome: Double = 0.0
    @Published var weeklyWorkHours: Int = 0
    
    @UserDefault<Set<Weekday>>("weekdays", defaultValue: Set<Weekday>())
    @Published var weekdays = Set<Weekday>()
    
    @UserDefault("ShowOnStart", defaultValue: true)
    var showOnStart: Bool {
        willSet {
            objectWillChange.send()
        }
    }
}
