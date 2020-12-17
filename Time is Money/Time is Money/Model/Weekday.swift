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
    case monday = "Mon"
    case tuesday = "Tue"
    case wednesday = "Wed"
    case thursday = "Thu"
    case friday = "Fri"
    case saturday = "Sat"
    case sunday = "Sun"
}

extension Weekday {
    public var id: String {
        return self.localizedLong()
    }
    
    public func localized() -> String {
        NSLocalizedString("\(self.rawValue)_weekday_short", comment: "")
    }
    
    public func localizedMedium() -> String {
        NSLocalizedString("\(self.rawValue)_weekday_medium", comment: "")
    }
    
    public func localizedLong() -> String {
        NSLocalizedString("\(self.rawValue)_weekday_long", comment: "")
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
