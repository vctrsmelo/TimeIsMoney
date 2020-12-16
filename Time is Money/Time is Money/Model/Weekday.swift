//
//  Weekday.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 06/01/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation
import SwiftUI

public enum Weekday: String, Codable, Identifiable {
    
    public var id: String {
        return self.localizedLong()
    }
    
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
            return "Mon_weekday_short"
        case .tuesday:
            return "Tue_weekday_short"
        case .wednesday:
            return "Wed_weekday_short"
        case .thursday:
            return "Thu_weekday_short"
        case .friday:
            return "Fri_weekday_short"
        case .saturday:
            return "Sat_weekday_short"
        case .sunday:
            return "Sun_weekday_short"
        }
    }
    
    public func localizedMedium() -> String {
        switch self {
        case .monday:
            return "Mon_weekday_medium"
        case .tuesday:
            return "Tue_weekday_medium"
        case .wednesday:
            return "Wed_weekday_medium"
        case .thursday:
            return "Thu_weekday_medium"
        case .friday:
            return "Fri_weekday_medium"
        case .saturday:
            return "Sat_weekday_medium"
        case .sunday:
            return "Sun_weekday_medium"
        }
    }
    
    public func localizedLong() -> String {
        switch self {
        case .monday:
            return "Mon_weekday_long"
        case .tuesday:
            return "Tue_weekday_long"
        case .wednesday:
            return "Wed_weekday_long"
        case .thursday:
            return "Thu_weekday_long"
        case .friday:
            return "Fri_weekday_long"
        case .saturday:
            return "Sat_weekday_long"
        case .sunday:
            return "Sun_weekday_long"
        }
    }
    
    static public func all() -> [Weekday] {
        return [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday]
    }
    
    /// mon, tue, wed, thu, fri
    static public func weekdays() -> [Weekday] {
        [.monday, .tuesday, .wednesday, .thursday, .friday]
    }
}

extension Array where Element == Weekday {
    func sortedWeekdays() -> [Weekday] {
        return Weekday.all().filter { contains($0) }
    }
}
