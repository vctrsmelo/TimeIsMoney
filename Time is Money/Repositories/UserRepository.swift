//
//  UserRepository.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 06/02/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation
import UIKit
import Combine

protocol UserRepository {
    func loadUser() -> User
}

struct UserDefaultsUserRepository: UserRepository {
    
    enum Key: String {
        case isOnboardingCompleted
        case monthlySalary = "MonthlySalary"
        case weeklyWorkHours = "WeeklyWorkHours"
        case workdays = "Workdays"
    }
    
    func loadUser() -> User {
        let monthlySalary = UserDefaults.standard.double(forKey: .monthlySalary)
        let weeklyWorkHours = UserDefaults.standard.maybeInteger(forKey: .weeklyWorkHours) ?? 40
        let isOnboardingCompleted = UserDefaults.standard.bool(forKey: .isOnboardingCompleted)
        let workdays = UserDefaults.standard.maybeWeekdays(forKey: .workdays) ?? Weekday.weekdays()
        
        return User(isOnboardingCompleted: isOnboardingCompleted, monthlySalary: monthlySalary.asDecimal(), weeklyWorkHours: weeklyWorkHours, workdays: workdays)
    }
    
}

private extension UserDefaults {
    
    func double(forKey key: UserDefaultsUserRepository.Key) -> Double {
        self.double(forKey: key.rawValue)
    }
    
    func integer(forKey key: UserDefaultsUserRepository.Key) -> Int {
        self.integer(forKey: key.rawValue)
    }
    
    func bool(forKey key: UserDefaultsUserRepository.Key) -> Bool {
        self.bool(forKey: key.rawValue)
    }
    
    func maybeWeekdays(forKey key: UserDefaultsUserRepository.Key) -> [Weekday]? {
        guard self.isKeyPresentInUserDefaults(key: key.rawValue) else { return nil }
        guard let workdaysData = UserDefaults.standard.data(forKey: key.rawValue),
              let weekdays = try? JSONDecoder().decode([Weekday].self, from: workdaysData) else {
                return nil
        }
        
        return weekdays
    }
    
    func maybeInteger(forKey key: UserDefaultsUserRepository.Key) -> Int? {
        guard self.isKeyPresentInUserDefaults(key: key.rawValue) else { return nil }
        return self.integer(forKey: key.rawValue)
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
