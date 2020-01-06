//
//  Weekday.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 06/01/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation

public enum Weekday: String, Codable {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    
    public func localized() -> String {
        switch self {
        case .monday:
            return "M"
        case .tuesday, .thursday:
            return "T"
        case .wednesday:
            return "W"
        case .friday:
            return "F"
        case .saturday, .sunday:
            return "S"
        }
    }
    
    public func localizedLong() -> String {
        switch self {
        case .monday:
            return "Monday"
        case .tuesday:
            return "Tuesday"
        case .wednesday:
            return "Wednesday"
        case .thursday:
            return "Thursday"
        case .friday:
            return "Friday"
        case .saturday:
            return "Saturday"
        case .sunday:
            return "Sunday"
        }
    }
    
    static public func all() -> [Weekday] {
        return [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday]
    }
}
