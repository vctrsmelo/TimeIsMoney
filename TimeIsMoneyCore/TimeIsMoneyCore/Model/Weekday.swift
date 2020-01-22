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
            return "Mon_weekday_short".localized
        case .tuesday:
            return "Tue_weekday_short".localized
        case .wednesday:
            return "Wed_weekday_short".localized
        case .thursday:
            return "Thu_weekday_short".localized
        case .friday:
            return "Fri_weekday_short".localized
        case .saturday:
            return "Sat_weekday_short".localized
        case .sunday:
            return "Sun_weekday_short".localized
        }
    }
    
    public func localizedMedium() -> String {
        switch self {
       case .monday:
            return "Mon_weekday_medium".localized
        case .tuesday:
            return "Tue_weekday_medium".localized
        case .wednesday:
            return "Wed_weekday_medium".localized
        case .thursday:
            return "Thu_weekday_medium".localized
        case .friday:
            return "Fri_weekday_medium".localized
        case .saturday:
            return "Sat_weekday_medium".localized
        case .sunday:
            return "Sun_weekday_medium".localized
        }
    }
    
    public func localizedLong() -> String {
        switch self {
        case .monday:
            return "Mon_weekday_long".localized
        case .tuesday:
            return "Tue_weekday_long".localized
        case .wednesday:
            return "Wed_weekday_long".localized
        case .thursday:
            return "Thu_weekday_long".localized
        case .friday:
            return "Fri_weekday_long".localized
        case .saturday:
            return "Sat_weekday_long".localized
        case .sunday:
            return "Sun_weekday_long".localized
        }
    }
    
    static public func all() -> [Weekday] {
        return [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday]
    }
}
