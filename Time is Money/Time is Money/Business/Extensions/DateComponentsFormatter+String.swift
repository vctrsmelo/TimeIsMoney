//
//  Date+Extensions.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 01/02/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation

extension DateComponentsFormatter {
    func string(from components: DateComponents) -> String? {
        let currentDate = Date()
        guard let futureDate = Calendar.current.date(byAdding: components, to: currentDate) else { return nil }

        return string(from: currentDate, to: futureDate)
    }
}
