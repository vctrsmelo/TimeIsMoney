//
//  ScenarioFactory.swift
//  Time is Money
//
//  Created by Victor Melo on 08/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

struct ScenarioFactory {
    
    enum Workplace {
        case office
    }
    
    static func getAllScenarios(for workplace: Workplace, avatar: Avatar) -> [Image] {
        switch workplace {
        case .office: return officeScenarios(avatar: avatar)
        }
    }
    
    static private func officeScenarios(avatar: Avatar) -> [Image] {
    
        let scenarios = [
            Image("office_\(avatar.scenarioString)_table0"),
            Image("office_\(avatar.scenarioString)_table1"),
            Image("office_\(avatar.scenarioString)_table2"),
            Image("office_\(avatar.scenarioString)_table3"),
            Image("office_\(avatar.scenarioString)_table4"),
            Image("office_\(avatar.scenarioString)_table5"),
            Image("office_\(avatar.scenarioString)_table6"),
            Image("office_\(avatar.scenarioString)_table7"),
            Image("office_\(avatar.scenarioString)_table8"),
            Image("office_\(avatar.scenarioString)_table9"),
            Image("office_\(avatar.scenarioString)_table10"),
            Image("office_\(avatar.scenarioString)_table11"),
            Image("office_\(avatar.scenarioString)_table12"),
            Image("office_\(avatar.scenarioString)_table13")
        ]
        
        return scenarios
    }
    
    
    static func getScenario(from scenarios: [Image], price: NSDecimalNumber, user: User) -> Image {
        let maxIndex = NSDecimalNumber(value: scenarios.count-1)
        let maxPrice = NSDecimalNumber(value: max(1,user.monthlySalary).asDouble())
        let normalizedIndex = round((price * maxIndex / maxPrice).doubleValue)
        let expensivityIndex = min(normalizedIndex, maxIndex.doubleValue)

        return scenarios[Int(expensivityIndex)]
    }

}
