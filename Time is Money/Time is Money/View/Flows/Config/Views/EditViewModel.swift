//
//  EditViewModel.swift
//  Time is Money
//
//  Created by Victor Melo on 07/11/22.
//  Copyright © 2022 Victor S Melo. All rights reserved.
//

import Foundation
import UIKit

struct EditViewModel {
    
    let themeOptions = ["Light", "Dark"]
    let hours = (0...168).map { "\($0)"}
    
    var currentThemeIndex: Int = 0
    var moneyPerHour: NSNumber = 0.0
    var showingAlert = false
    var themeSelectedIndex: Int = 0
    
    init() {
        self.buildCurrentTheme()
    }
    
    private mutating func buildCurrentTheme() {
        let currentTheme = UIScreen.main.traitCollection.userInterfaceStyle
        currentThemeIndex = currentTheme != .unspecified ? currentTheme.rawValue : 0
    }
    
    func setTheme(_ index: Int) {
        let newTheme: UIUserInterfaceStyle = index == 0 ? .light : .dark
        UIWindow.appearance().overrideUserInterfaceStyle = newTheme
    }
}
