//
//  Formatters.swift
//  Time is Money
//
//  Created by Victor Melo on 03/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation

extension Formatter {
    
    static var currency: NumberFormatter {
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        nf.isLenient = true
        return nf
    }
    
    static var decimal: NumberFormatter {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.isLenient = true
        return nf
    }
    
    static func hoursAndMinutes(seconds: TimeInterval) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour]
        formatter.zeroFormattingBehavior = .pad
        guard let string = formatter.string(from: seconds) else {
            return nil
        }
    
        return string
    }
}
