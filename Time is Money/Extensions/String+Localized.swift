//
//  String+Localized.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 21/01/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

public extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
