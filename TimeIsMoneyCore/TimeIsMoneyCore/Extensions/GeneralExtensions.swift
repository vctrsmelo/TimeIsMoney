//
//  GeneralExtensions.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 07/01/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation

extension Double {
    func truncated(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return trunc(self * divisor) / divisor
    }
}

