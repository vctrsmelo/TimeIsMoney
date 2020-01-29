//
//  Routine.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 29/01/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation

public struct Routine {
    public let value: Double
    public let period: RoutineTimePeriod
}

public enum RoutineTimePeriod {
    case weekly
    case daily
}
