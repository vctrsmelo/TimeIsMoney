//
//  UserDefaultsRepository.swift
//  Time is Money
//
//  Created by Victor Melo on 21/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation

public enum DataKey: String {
    case isOnboardingCompleted
    case monthlySalary = "MonthlySalary"
    case weeklyWorkHours = "WeeklyWorkHours"
    case workdays = "Workdays"
    case avatarId = "AvatarId"
    case workplace = "Workplace"
}

public struct UserDefaultsRepository {
    
    public func loadIsOnboardingCompleted() -> Bool {
        UserDefaults.standard.bool(forKey: DataKey.isOnboardingCompleted.rawValue)
    }
    
    func loadMonthlySalary() -> Double {
        UserDefaults.standard.double(forKey: DataKey.monthlySalary.rawValue)
    }
    
    func loadWeeklyWorkHours() -> Int {
        UserDefaults.standard.integer(forKey: DataKey.weeklyWorkHours.rawValue)
    }
    
    func loadWorkdays() -> [Weekday] {
        UserDefaults.standard.maybeWeekdays(forKey: DataKey.workdays.rawValue) ?? Weekday.weekdays()
    }
    
    func loadAvatarId() -> String {
        guard let id = UserDefaults.standard.string(forKey: DataKey.avatarId.rawValue) else {
            saveAvatarId("male2-deprecated")
            return loadAvatarId()
        }
        return id
    }
    
    func loadWorkplace() -> ScenarioFactory.Workplace {
        guard let rawValue = UserDefaults.standard.string(forKey: DataKey.workplace.rawValue) else {
            saveWorkplace(.office)
            return loadWorkplace()
        }
        
        return ScenarioFactory.Workplace.init(rawValue: rawValue) ?? .office
    }
    
    func saveIsOnboardingCompleted(_ isOnboardingCompleted: Bool) {
        UserDefaults.standard.set(isOnboardingCompleted, forKey: DataKey.isOnboardingCompleted.rawValue)
    }
    
    func saveMonthlySalary(_ monthlySalary: Double) {
        UserDefaults.standard.set(monthlySalary, forKey: DataKey.monthlySalary.rawValue)
    }
    
    func saveWeeklyWorkHours(_ weeklyWorkHours: Int) {
        UserDefaults.standard.set(weeklyWorkHours, forKey: DataKey.weeklyWorkHours.rawValue)
    }
    
    func saveWorkdays(_ workdays: [Weekday]) {
        if let encoded = try? JSONEncoder().encode(workdays) {
            UserDefaults.standard.set(encoded, forKey: DataKey.workdays.rawValue)
        }
    }
    
    func saveAvatarId(_ id: String) {
        UserDefaults.standard.set(id, forKey: DataKey.avatarId.rawValue)
    }
    
    func saveWorkplace(_ workplace: ScenarioFactory.Workplace) {
        UserDefaults.standard.set(workplace.rawValue, forKey: DataKey.workplace.rawValue)
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

