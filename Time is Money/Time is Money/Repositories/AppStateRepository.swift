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
    func loadAvatarId() -> String
    func loadWorkplace() -> ScenarioFactory.Workplace

    func saveUser(_ user: User)
    func saveAvatarId(_ id: String)
    func saveWorkplace(_ workplace: ScenarioFactory.Workplace)
}

struct UserDefaultsAppStateRepository: AppStateRepository {
    
    private let ud = UserDefaultsRepository()
    
    func loadUser() -> User {
        return User(isOnboardingCompleted: ud.loadIsOnboardingCompleted(),
                    monthlySalary: ud.loadMonthlySalary().asDecimal(),
                    weeklyWorkHours: ud.loadWeeklyWorkHours(),
                    workdays: ud.loadWorkdays())
    }
    
    func loadAvatarId() -> String {
        ud.loadAvatarId()
    }
    
    func loadWorkplace() -> ScenarioFactory.Workplace {
        ud.loadWorkplace()
    }
    
    func saveUser(_ user: User) {
        ud.saveIsOnboardingCompleted(user.isOnboardingCompleted)
        ud.saveMonthlySalary(user.monthlySalary.asDouble())
        ud.saveWeeklyWorkHours(user.weeklyWorkHours)
        ud.saveWorkdays(user.workdays)
    }
    
    func saveAvatarId(_ id: String) {
        ud.saveAvatarId(id)
    }
    
    func saveWorkplace(_ workplace: ScenarioFactory.Workplace) {
        ud.saveWorkplace(workplace)
    }
}

