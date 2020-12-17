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
    func loadAppState()
    func saveAppState()
}

struct MainInteractorImp: MainInteractor {
    
    let userRepository: AppStateRepository
    let appState: AppState
    
    init(userRepository: AppStateRepository, appState: AppState) {
        self.userRepository = userRepository
        self.appState = appState
    }
    
    func loadAppState() {
        appState.user = userRepository.loadUser()
        appState.avatarId = userRepository.loadAvatarId()
        appState.workplace = userRepository.loadWorkplace()
        appState.designSystem = userRepository.loadDesignSystem()
    }
    
    func saveAppState() {
        userRepository.saveUser(appState.user)
        userRepository.saveAvatarId(appState.avatarId)
        userRepository.saveWorkplace(appState.workplace)
        userRepository.saveDesignSystem(type(of: appState.designSystem).id)
    }
}
