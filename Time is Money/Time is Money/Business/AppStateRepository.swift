import Foundation
import UIKit
import Combine

protocol AppStateRepository {
    func loadUser() -> User
    func loadAvatarId() -> String
    func loadWorkplace() -> ScenarioFactory.Workplace

    func saveUser(_ user: User)
    func saveAvatarId(_ id: String)
    func saveWorkplace(_ workplace: ScenarioFactory.Workplace)
}

struct UserDefaultsAppStateRepository: AppStateRepository {
    
    enum Key: String {
        case isOnboardingCompleted
        case monthlySalary = "MonthlySalary"
        case weeklyWorkHours = "WeeklyWorkHours"
        case workdays = "Workdays"
        case avatarId = "AvatarId"
        case workplace = "Workplace"
    }
    
    func loadUser() -> User {
        let monthlySalary = UserDefaults.standard.double(forKey: Key.monthlySalary.rawValue)
        let weeklyWorkHours = UserDefaults.standard.maybeInteger(forKey: Key.weeklyWorkHours.rawValue) ?? 40
        let isOnboardingCompleted = UserDefaults.standard.bool(forKey: Key.isOnboardingCompleted.rawValue)
        let workdays = UserDefaults.standard.maybeWeekdays(forKey: Key.workdays.rawValue) ?? Weekday.weekdays()
        
        return User(isOnboardingCompleted: isOnboardingCompleted, monthlySalary: NSDecimalNumber(value: monthlySalary), weeklyWorkHours: weeklyWorkHours, workdays: workdays)
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
    
    func loadWorkplace() -> ScenarioFactory.Workplace {
        guard let rawValue = UserDefaults.standard.string(forKey: Key.workplace.rawValue) else {
            saveWorkplace(.office)
            return loadWorkplace()
        }
        
        return ScenarioFactory.Workplace.init(rawValue: rawValue) ?? .office
    }
    
    func saveAvatarId(_ id: String) {
        UserDefaults.standard.set(id, forKey: Key.avatarId.rawValue)
    }
    
    func saveWorkplace(_ workplace: ScenarioFactory.Workplace) {
        UserDefaults.standard.set(workplace.rawValue, forKey: Key.workplace.rawValue)
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
