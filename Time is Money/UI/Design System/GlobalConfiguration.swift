//
//  GlobalConfiguration.swift
//  Time is Money
//
//  Created by Victor Melo on 11/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

var config: ThemeConfigurationProtocol {
    GlobalConfiguration.configuration
}

class GlobalConfiguration {
   
    static private var interfaceStyle: UIUserInterfaceStyle {
        UIViewController().traitCollection.userInterfaceStyle
    }
    
    private static var currentInterfaceStyle = UIViewController().traitCollection.userInterfaceStyle
    
    static var configuration: ThemeConfigurationProtocol {
        (interfaceStyle == .dark) ? darkModeConfiguration : defaultConfiguration
    }
    
    static private let defaultConfiguration = DefaultConfiguration()
    static private let darkModeConfiguration = DarkModeConfiguration()

}
