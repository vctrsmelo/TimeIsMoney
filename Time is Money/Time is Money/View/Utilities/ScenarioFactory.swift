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
    
    static func getScenario(from scenarios: [Image], price: NSDecimalNumber, user: User) -> Image {
        let maxIndex = NSDecimalNumber(value: scenarios.count-1)
        let maxPrice = NSDecimalNumber(value: max(1,user.monthlySalary).asDouble())
        let normalizedIndex = round((price * maxIndex / maxPrice).doubleValue)
        let expensivityIndex = min(normalizedIndex, maxIndex.doubleValue)

        return scenarios[Int(expensivityIndex)]
    }
}

// MARK: - Office

extension ScenarioFactory {
    static private func officeScenarios(avatar: Avatar) -> [String] {
        (0...13).map { "office_\(avatar.id)_table\($0)" }
    }
}
