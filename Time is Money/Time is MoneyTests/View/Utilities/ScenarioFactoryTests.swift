//
//  ScenarioFactoryTests.swift
//  Time is MoneyTests
//
//  Created by Victor Melo on 16/12/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import XCTest
@testable import Time_is_Money

class ScenarioFactoryTests: XCTestCase {

    func test_onCallGetAllScenarios_withOfficeWorkspace_expectsAllOfficeImages() {
        let avatar = AvatarMale1()
        let expectedScenarios = expectedOfficeScenarios(avatarId: avatar.id)
        
        let scenarios = ScenarioFactory.getAllScenarios(for: .office, avatar: avatar)
        
        XCTAssertEqual(Set(scenarios), Set(expectedScenarios))
    }
    
    // MARK: - Helpers
    
    func expectedOfficeScenarios(avatarId: String) -> [String] {
        return (0...13).map { "office_\(avatarId)_table\($0)" }
    }
}
