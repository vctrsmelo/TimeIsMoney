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

protocol AppStateRepository {
    func loadUser() -> User
    func saveUser(_ user: User)

    func loadAvatarId() -> String
    func saveAvatarId(_ id: String)

    func loadWorkplace() -> ScenarioFactory.Workplace
    func saveWorkplace(_ workplace: ScenarioFactory.Workplace)
    
    func loadDesignSystem() -> ThemeConfigurationProtocol
    func saveDesignSystem(_ id: String)
}

struct UserDefaultsAppStateRepository: AppStateRepository {
    
    enum Key: String {
        case isOnboardingCompleted
        case monthlySalary = "MonthlySalary"
        case weeklyWorkHours = "WeeklyWorkHours"
        case workdays = "Workdays"
        case avatarId = "AvatarId"
        case workplace = "Workplace"
        case designSystem = "DesignSystem"
    }
    
    func loadUser() -> User {
        let monthlySalary = UserDefaults.standard.double(forKey: Key.monthlySalary.rawValue)
        let weeklyWorkHours = UserDefaults.standard.maybeInteger(forKey: Key.weeklyWorkHours.rawValue) ?? 40
        let isOnboardingCompleted = UserDefaults.standard.bool(forKey: Key.isOnboardingCompleted.rawValue)
        let workdays = UserDefaults.standard.maybeWeekdays(forKey: Key.workdays.rawValue) ?? Weekday.weekdays()
        
        return User(isOnboardingCompleted: isOnboardingCompleted, monthlySalary: monthlySalary.asDecimal(), weeklyWorkHours: weeklyWorkHours, workdays: workdays)
    }
    
    func saveUser(_ user: User) {
        UserDefaults.standard.set(user.isOnboardingCompleted, forKey: Key.isOnboardingCompleted.rawValue)
        UserDefaults.standard.set(user.monthlySalary, forKey: Key.monthlySalary.rawValue)
        UserDefaults.standard.set(user.weeklyWorkHours, forKey: Key.weeklyWorkHours.rawValue)
        
        if let encoded = try? JSONEncoder().encode(user.workdays) {
            UserDefaults.standard.set(encoded, forKey: Key.workdays.rawValue)
        }
    }
    
    func loadAvatarId() -> String {
        guard let id = UserDefaults.standard.string(forKey: Key.avatarId.rawValue) else {
            saveAvatarId("male2")
            return loadAvatarId()
        }
        
        return id
    }
    
    func saveAvatarId(_ id: String) {
        UserDefaults.standard.set(id, forKey: Key.avatarId.rawValue)
    }
    
    func loadWorkplace() -> ScenarioFactory.Workplace {
        guard let rawValue = UserDefaults.standard.string(forKey: Key.workplace.rawValue) else {
            saveWorkplace(.office)
            return loadWorkplace()
        }
        
        return ScenarioFactory.Workplace.init(rawValue: rawValue) ?? .office
    }
    
    func saveWorkplace(_ workplace: ScenarioFactory.Workplace) {
        UserDefaults.standard.set(workplace.rawValue, forKey: Key.workplace.rawValue)
    }
    
    func loadDesignSystem() -> ThemeConfigurationProtocol {
        guard let id = UserDefaults.standard.string(forKey: Key.designSystem.rawValue) else {
            saveDesignSystem(ClassicConfiguration.id)
            return loadDesignSystem()
        }
        
        return DesignSystemFactory.getBy(id)
    }
    
    func saveDesignSystem(_ id: String) {
        UserDefaults.standard.set(id, forKey: Key.designSystem.rawValue)
    }
}

private extension UserDefaults {
        
    func maybeWeekdays(forKey key: String) -> [Weekday]? {
        guard self.isKeyPresentInUserDefaults(key: key) else { return nil }
        guard let workdaysData = UserDefaults.standard.data(forKey: key),
              let weekdays = try? JSONDecoder().decode([Weekday].self, from: workdaysData) else {
                return nil
        }
        
        return weekdays
    }
    
    func maybeInteger(forKey key: String) -> Int? {
        guard self.isKeyPresentInUserDefaults(key: key) else { return nil }
        return self.integer(forKey: key)
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
