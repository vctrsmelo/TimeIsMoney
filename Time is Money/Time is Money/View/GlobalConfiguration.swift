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

var config: ThemeProtocol {
    GlobalConfiguration.theme
}

class GlobalConfiguration {
    static var theme: ThemeProtocol = LightTheme()
}
