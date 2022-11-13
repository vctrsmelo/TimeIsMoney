//
//  AppState.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 07/02/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var user = User()
    @Published var avatarId = "male2-deprecated"
    @Published var workplace = ScenarioFactory.Workplace.office
    @Published var currentPrice = Currency(value: 0.0)
    @Published var system = System()
    
    func getCurrentValue() -> Price {
        return Price(currency: currentPrice, user: user)
    }
}

extension AppState {
    struct System {
        public var isActive: Bool = false
        public var keyboardHeight: CGFloat = 0
    }
}
