//
//  Persistence.swift
//  Time is Money
//
//  Created by Victor Melo on 05/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation

class Persistence {
    
}

import Foundation
import Combine

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
