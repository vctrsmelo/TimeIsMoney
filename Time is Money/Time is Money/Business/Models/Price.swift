//
//  Money.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 31/01/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation

struct Price {
    
     enum MonetaryUnit {
        case currency(_ value: Currency)
        case seconds(_ value: TimeInterval)
    }
    
    let value: MonetaryUnit
    var user: User
    
    init(valueType: MonetaryUnit, user: User) {
        self.value = valueType
        self.user = user
    }
    
     init(currency: Currency, user: User) {
        self.value = MonetaryUnit.currency(currency)
        self.user = user
    }
    
     init(currency: Double, user: User) {
        self.value = MonetaryUnit.currency(Currency(value: currency))
        self.user = user
    }
    
     init(seconds: TimeInterval, user: User) {
        self.value = MonetaryUnit.seconds(seconds)
        self.user = user
    }
    
     func getAsCurrency() -> Currency? {
        var moneyValue: Currency?
        switch value {
        case .currency(let value):
            moneyValue = value
        case .seconds(let value):
            if case .success(let mValue) = value.asCurrency(for: user) {
                moneyValue = mValue
            }
        }

        return moneyValue
    }
    
     func getAsTimeInSeconds() -> TimeInterval? {
        var timeInSecondsValue: TimeInterval?
        switch value {
        case .currency(let value):
            if case .success(let tValue) = value.asSeconds(for: user) {
                timeInSecondsValue = tValue.doubleValue
            }
        case .seconds(let value):
            timeInSecondsValue = value
        }
        
        return timeInSecondsValue
    }
}

private extension TimeInterval {
    func asCurrency(for user: User) -> Result<Currency, CalculatorError> {
        return Calculator.getMoneyReceivedFromWorkSeconds(workSeconds: self, user: user)
    }
}

private extension Currency {
    func asSeconds(for user: User) -> Result<NSDecimalNumber, CalculatorError> {
        return Calculator.getWorkTimeToPay(for: self, user: user)
    }
}
