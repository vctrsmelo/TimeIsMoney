//
//  ScenarioFactory.swift
//  Time is Money
//
//  Created by Victor Melo on 08/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

struct ScenarioFactory {
    
    enum Workplace: String {
        case office
    }
    
    static func getAllScenarios(for workplace: Workplace, avatar: Avatar) -> [String] {
        switch workplace {
        case .office: return officeScenarios(avatar: avatar)
        }
    }
    
    static private func officeScenarios(avatar: Avatar) -> [String] {
        let id = avatar.id != "male2-deprecated" ? avatar.id : "male2"

        return officeScenarioTitles(avatarId: id)
    }
    
    static private func officeScenarioTitles(avatarId: String) -> [String] {
        (0...13).map { "office_\(avatarId)_table\($0)" }
    }
    
    
    static func getScenario(from scenarios: [Image], price: NSDecimalNumber, user: User) -> Image {
        let maxIndex = NSDecimalNumber(value: scenarios.count-1)
        let maxPrice = NSDecimalNumber(value: max(1,user.monthlySalary).asDouble())
        let normalizedIndex = round((price * maxIndex / maxPrice).doubleValue)
        let expensivityIndex = min(normalizedIndex, maxIndex.doubleValue)

        return scenarios[Int(expensivityIndex)]
    }

}
