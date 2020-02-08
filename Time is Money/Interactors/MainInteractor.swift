//
//  MainInteractor.swift
//  Time is Money
//
//  Created by Victor Melo on 06/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation

protocol MainInteractor {
    var appState: AppState { get }
    func loadUser()
    func saveUser()
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
    
    func saveUser() {
        userRepository.saveUser(user: appState.user)
    }
}
