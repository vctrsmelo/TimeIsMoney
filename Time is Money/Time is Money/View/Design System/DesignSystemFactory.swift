//
//  DesignSystemFactory.swift
//  Time is Money
//
//  Created by Victor Melo on 17/12/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation

struct DesignSystemFactory {
    static func getBy(_ id: String) -> ThemeConfigurationProtocol {
        switch id {
        case ClassicConfiguration.id: return ClassicConfiguration()
        case CleanConfiguration.id: return CleanConfiguration()
        default: return ClassicConfiguration()
        }
    }
}
