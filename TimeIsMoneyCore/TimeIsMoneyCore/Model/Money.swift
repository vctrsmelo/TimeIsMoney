//
//  Money.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 31/01/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation

public typealias Money = NSDecimalNumber

public struct Value {
    
    public enum ValueType {
        case monetary(_ value: Money)
        case timeInSeconds(_ value: TimeInterval)
    }
    
    public let value: ValueType
    
    init(valueType: ValueType) {
        self.value = valueType
    }
    
    init(money: Money) {
        self.value = ValueType.monetary(money)
    }
    
    init(money: Double) {
        self.value = ValueType.monetary(Money(value: money))
    }
    
    init(workSeconds: TimeInterval) {
        self.value = ValueType.timeInSeconds(workSeconds)
    }
    
    func getAsMoney(for user: User) -> Money {
        switch value {
        case .monetary(let value):
            return value
        case .timeInSeconds(let value):
            return value.asMoney(for: user)
        }
    }
    
    func getAsTimeInSeconds(for user: User) -> Result<WorkTimeSeconds, CalculatorError> {
        switch value {
        case .monetary(let value):
            return value.asSeconds(for: user)
        case .timeInSeconds(let value):
            return .success(value)
        }
    }
}

private extension TimeInterval {
    
    func asMoney(for user: User) -> Money {
        return Money(integerLiteral: 1000)
    }
}

private extension Money {
    func asSeconds(for user: User) -> Result<WorkTimeSeconds, CalculatorError> {
        return Calculator.getWorkTimeToPay(for: self, user: user)
    }
}
