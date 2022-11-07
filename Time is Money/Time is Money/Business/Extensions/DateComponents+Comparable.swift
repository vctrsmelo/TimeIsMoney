//
//  DateComponents+Comparable.swift
//  Time is Money
//
//  Created by Victor Melo on 07/06/22.
//  Copyright © 2022 Victor S Melo. All rights reserved.
//

import Foundation

extension DateComponents: Comparable {
    public static func < (lhs: DateComponents, rhs: DateComponents) -> Bool {
        (lhs.year   ?? 0) < (rhs.year   ?? 0) ||
        (lhs.month  ?? 0) < (rhs.month  ?? 0) ||
        (lhs.day    ?? 0) < (rhs.day    ?? 0) ||
        (lhs.hour   ?? 0) < (rhs.hour   ?? 0) ||
        (lhs.minute ?? 0) < (rhs.minute ?? 0) ||
        (lhs.second ?? 0) < (rhs.second ?? 0)
    }
    
    
}
