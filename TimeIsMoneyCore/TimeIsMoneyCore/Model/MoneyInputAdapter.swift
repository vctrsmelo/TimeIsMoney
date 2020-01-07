//
//  MoneyInputAdapter.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 07/01/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation
import Combine

public class MoneyInputAdapter: ObservableObject {
    @Published public private(set) var value: Double = 0.0
    
    public enum DecimalCharacter: Int {
        case _0 = 0
        case _1 = 1
        case _2 = 2
        case _3 = 3
        case _4 = 4
        case _5 = 5
        case _6 = 6
        case _7 = 7
        case _8 = 8
        case _9 = 9
        
        func fromInt(_ int: Int) -> Self? {
            if !((0...9).contains(int)) {
                assertionFailure("Error at MoneyInputAdapter fromInt(_: Int): Invalid int. Should be between 0 and 9.")
            }
            
            return DecimalCharacter(rawValue: int)
        }
    }
    
    public init() { }
    
    public func append(_ int: Int) {
        guard let decimal = DecimalCharacter(rawValue: int) else { return }
        self.append(decimal)
    }
    
    public func append(_ decimal: DecimalCharacter?) {
        guard let decimal = decimal else { return }
        value = (value*10 + Double(decimal.rawValue)/100).truncated(toPlaces: 2)
    }
    
    public func dropLast() {
        value = (value/10.0).truncated(toPlaces: 2)
    }
}
