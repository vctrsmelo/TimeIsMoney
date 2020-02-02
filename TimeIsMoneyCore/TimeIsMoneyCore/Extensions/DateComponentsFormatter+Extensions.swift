//
//  Date+Extensions.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 01/02/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation

extension DateComponentsFormatter {
    func string(from seconds: NSDecimalNumber) -> String? {
        return string(from: Date(), to: Date().addingTimeInterval(seconds.timeIntervalValue))
    }
}
