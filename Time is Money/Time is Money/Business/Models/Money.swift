//
//  Money.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 31/01/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation

typealias Money = NSDecimalNumber

struct Value {
    
     enum ValueType {
        case monetary(_ value: Money)
        case timeInSeconds(_ value: TimeInterval)
    }
    
    let value: ValueType
    var user: User
    
    init(valueType: ValueType, user: User) {
        self.value = valueType
        self.user = user
    }
    
     init(money: Money, user: User) {
        self.value = ValueType.monetary(money)
        self.user = user
    }
    
     init(money: Double, user: User) {
        self.value = ValueType.monetary(Money(value: money))
        self.user = user
    }
    
     init(workSeconds: TimeInterval, user: User) {
        self.value = ValueType.timeInSeconds(workSeconds)
        self.user = user
    }
    
     func getAsMoney() -> Money? {
        var moneyValue: Money?
        switch value {
        case .monetary(let value):
            moneyValue = value
        case .timeInSeconds(let value):
            if case .success(let mValue) = value.asMoney(for: user) {
                moneyValue = mValue
            }
        }

        return moneyValue
    }
    
     func getAsTimeInSeconds() -> TimeInterval? {
        var timeInSecondsValue: TimeInterval?
        switch value {
        case .monetary(let value):
            if case .success(let tValue) = value.asSeconds(for: user) {
                timeInSecondsValue = tValue.doubleValue
            }
        case .timeInSeconds(let value):
            timeInSecondsValue = value
        }
        
        return timeInSecondsValue
    }
}

private extension TimeInterval {
    func asMoney(for user: User) -> Result<Money, CalculatorError> {
        return Calculator.getMoneyReceivedFromWorkSeconds(workSeconds: self, user: user)
    }
}

private extension Money {
    func asSeconds(for user: User) -> Result<NSDecimalNumber, CalculatorError> {
        return Calculator.getWorkTimeToPay(for: self, user: user)
    }
}
