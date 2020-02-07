//
//  MainInteractor.swift
//  Time is Money
//
//  Created by Victor Melo on 06/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation
import TimeIsMoneyCore

protocol MainInteractor {
    func loadUser()
}

struct RealMainInteractor: MainInteractor {
    
    let userRepository: UserRepository
    let appState: AppState
    
    init(userRepository: UserRepository, appState: AppState) {
        self.userRepository = userRepository
        self.appState = appState
    }
    
    func loadUser() {
        appState.user = userRepository.loadUser()
    }
    
}
