//
//  UserSettings.swift
//  Time is Money
//
//  Created by Victor Melo on 05/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation

class UserSettings: ObservableObject {
    @Published var weekdays = Set<Weekday>()
}
