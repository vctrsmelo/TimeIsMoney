//
//  Weekday.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 06/01/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation
import SwiftUI
import Rswift

public enum WidgetWeekday: String, Codable, Identifiable {
    
    public var id: String {
        return self.rawValue
    }
    
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    
    static public func all() -> [WidgetWeekday] {
        return [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday]
    }
    
    /// mon, tue, wed, thu, fri
    static public func weekdays() -> [WidgetWeekday] {
        [.monday, .tuesday, .wednesday, .thursday, .friday]
    }
}

extension Array where Element == WidgetWeekday {
    func sortedWeekdays() -> [WidgetWeekday] {
        return WidgetWeekday.all().filter { contains($0) }
    }
}
