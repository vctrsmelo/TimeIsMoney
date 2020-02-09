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
    
    static func getAllScenarios(for workplace: Workplace, avatar: Avatar) -> [Scenario] {
        switch workplace {
        case .office: return officeScenarios(avatar: avatar)
        }
    }
    
    static func officeScenarios(avatar: Avatar) -> [Scenario] {
        
        let tables = [
            Image("office_table0"),
            Image("office_table1"),
            Image("office_table2"),
            Image("office_table3"),
            Image("office_table4"),
            Image("office_table5"),
            Image("office_table6"),
            Image("office_table7"),
            Image("office_table8"),
            Image("office_table9"),
            Image("office_table10"),
            Image("office_table11"),
            Image("office_table12"),
            Image("office_table13")
        ]
        
        var scenarios = [Scenario]()
        
        for i in 0 ..< tables.count {
            
            let feeling: Avatar.Feeling
            if i <= 4 {
                feeling = .happy
            } else if i <= 9 {
                feeling = .normal
            } else {
                feeling = .sad
            }
            
            let avatarView = AvatarView(avatar: avatar, feeling: feeling)
            scenarios.append(Scenario(workplace: tables[i], avatarView: avatarView, avatarXOffset: 20, avatarYOffset: -100, avatarViewScale: 0.5))
        }
        
        return scenarios
    }
    
    
    static func getScenario(from scenarios: [Scenario], price: NSDecimalNumber, user: User) -> Scenario {
        let maxIndex = NSDecimalNumber(value: scenarios.count-1)
        let maxPrice = NSDecimalNumber(value: max(1,user.monthlySalary).asDouble())
        let normalizedIndex = round((price * maxIndex / maxPrice).doubleValue)
        let expensivityIndex = min(normalizedIndex, maxIndex.doubleValue)

        return scenarios[Int(expensivityIndex)]
    }

}
