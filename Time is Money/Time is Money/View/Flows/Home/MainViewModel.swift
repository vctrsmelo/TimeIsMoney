//
//  MainViewModel.swift
//  Time is Money
//
//  Created by Victor Melo on 10/06/21.
//  Copyright © 2021 Victor S Melo. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

class MainViewState: ObservableObject {
    
    @Published var appState: AppState
    @Published var offsetValue: CGFloat = 0.0
    @Published var showEditView = false
    @Published var topTextPadding: CGFloat = 0.0
    @Published var isKeyboardVisible = false
    @Published var isAlertShowing: Bool = false
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    var timeMessage: String {
        let timeMessage: String
        
        if let money = appState.getCurrentValue().getAsMoney(), money < Money(value: 0.01) {
            timeMessage = R.string.localizable.itSOnTheHouse🤑()
        } else if appState.user.dailyWorkHours <= NSDecimalNumber(value: 0.1) || appState.user.monthlySalary.decimalValue <= Decimal(0.01) {
            timeMessage = R.string.localizable.foreverIGuess😮()
            
        } else if let calculatedPrice = appState.getCurrentValue().getAsTimeInSeconds() {
            timeMessage = calculatedPrice < 1 ? R.string.localizable.lessThanASecond() :
            TimeTextTranslator.getWorkTimeDescriptionToPay(for: NSDecimalNumber(value: calculatedPrice), user: appState.user)
        } else {
            timeMessage = "¯\\_(ツ)_/¯"
        }
        
        return timeMessage
    }
    
    var priceAsSeconds: Double {
        return appState.getCurrentValue().getAsTimeInSeconds() ?? 0.0
    }
}


class MainViewModel: ObservableObject {
    
    enum State {
        case valid(message: String, inputValue: Money)
        case free
        case infinite
    }
    
    enum Event {
        case onAppear
        case onUpdateValue(Decimal)
    }
    
    @Published var mainViewState: MainViewState
    
    init(appState: AppState) {
        self.mainViewState = MainViewState(appState: appState)
    }
}

extension MainViewModel {
    static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case let .valid(message, inputValue):
            return reduceValid(message: message, inputValue: inputValue, event: event)
        case .free:
            return reduceFree(event: event)
        case .infinite:
            return reduceInfinite(event: event)
        }
    }
    
    static private func reduceValid(message: String, inputValue: Money, event: Event) -> State {
        switch event {
        case .onAppear:
            return .free
        case let .onUpdateValue(newValue):
            return .valid(message: "Teste reduceValid", inputValue: Money(decimal: newValue))
        }
    }
    
    static private func reduceFree(event: Event) -> State {
        switch event {
        case .onAppear:
            return .free
        case let .onUpdateValue(newValue):
            return .valid(message: "Teste reduceFree", inputValue: Money(decimal: newValue))
        }
    }
    
    static private func reduceInfinite(event: Event) -> State {
        switch event {
        case .onAppear:
            return .free
        case let .onUpdateValue(newValue):
            return .valid(message: "Teste reduceInfinite", inputValue: Money(decimal: newValue))
        }
    }
}
