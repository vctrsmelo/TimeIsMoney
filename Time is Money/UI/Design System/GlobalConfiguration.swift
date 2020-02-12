//
//  GlobalConfiguration.swift
//  Time is Money
//
//  Created by Victor Melo on 11/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation

let config = GlobalConfiguration.configuration

class GlobalConfiguration {
    static var configuration: ThemeConfigurationProtocol = DefaultConfiguration()
}
