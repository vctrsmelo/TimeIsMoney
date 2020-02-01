//
//  Date+Extensions.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 01/02/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation
//
//extension Date {
//    func adding(seconds: NSDecimalNumber) -> Date? {
//        let futureDate = Calendar.current.date(byAdding: .second, value: seconds.intValue, to: self)
//
//        return futureDate
//    }
//}
//
extension DateComponentsFormatter {
    func string(from seconds: NSDecimalNumber) -> String? {
        return string(from: Date(), to: Date().addingTimeInterval(seconds.timeIntervalValue))
    }
}
