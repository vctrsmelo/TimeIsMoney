//
//  WidgetUserDefaultsRepository.swift
//  Calculator Widget
//
//  Created by Victor Melo on 22/02/20.
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
    
    public init() {}
    
    public func loadIsOnboardingCompleted() -> Bool {
        userDefaults.bool(forKey: DataKey.isOnboardingCompleted.rawValue)
    }
    
    public func loadMonthlySalary() -> Double {
        userDefaults.double(forKey: DataKey.monthlySalary.rawValue)
    }
    
    public func loadWeeklyWorkHours() -> Int {
        userDefaults.integer(forKey: DataKey.weeklyWorkHours.rawValue)
    }
    
    public func loadWorkdays() -> [WidgetWeekday] {
        userDefaults.maybeWidgetWeekdays(forKey: DataKey.workdays.rawValue) ?? WidgetWeekday.weekdays()
    }
    
    func loadAvatarId() -> String {
        guard let id = userDefaults.string(forKey: DataKey.avatarId.rawValue) else {
            saveAvatarId("male2-deprecated")
            return loadAvatarId()
        }
        return id
    }
    func saveIsOnboardingCompleted(_ isOnboardingCompleted: Bool) {
        userDefaults.set(isOnboardingCompleted, forKey: DataKey.isOnboardingCompleted.rawValue)
    }
    
    func saveMonthlySalary(_ monthlySalary: Double) {
        userDefaults.set(monthlySalary, forKey: DataKey.monthlySalary.rawValue)
    }
    
    func saveWeeklyWorkHours(_ weeklyWorkHours: Int) {
        userDefaults.set(weeklyWorkHours, forKey: DataKey.weeklyWorkHours.rawValue)
    }
    
    func saveWorkdays(_ workdays: [WidgetWeekday]) {
        if let encoded = try? JSONEncoder().encode(workdays) {
            userDefaults.set(encoded, forKey: DataKey.workdays.rawValue)
        }
    }
    
    func saveAvatarId(_ id: String) {
        userDefaults.set(id, forKey: DataKey.avatarId.rawValue)
    }

}

private extension UserDefaults {
        
    func maybeWidgetWeekdays(forKey key: String) -> [WidgetWeekday]? {
        guard self.isKeyPresentInUserDefaults(key: key) else { return nil }
        guard let workdaysData = userDefaults.data(forKey: key),
              let WidgetWeekdays = try? JSONDecoder().decode([WidgetWeekday].self, from: workdaysData) else {
                return nil
        }
        
        return WidgetWeekdays
    }
    
    func maybeInteger(forKey key: String) -> Int? {
        guard self.isKeyPresentInUserDefaults(key: key) else { return nil }
        return self.integer(forKey: key)
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return userDefaults.object(forKey: key) != nil
    }
}

