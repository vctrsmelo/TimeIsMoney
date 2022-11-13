//
//  EditViewModel.swift
//  Time is Money
//
//  Created by Victor Melo on 07/11/22.
//  Copyright © 2022 Victor S Melo. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct EditViewModel {
    
    let themeOptions = ["Light", "Dark"]
    let hours = (0...168).map { "\($0)"}
    
    var moneyPerHour: NSNumber = 0.0
    var showingAlert = false
    var themeSelectedIndex: Int = 0
    
    private let appState: AppState = InteractorsContainer.defaultValue.mainInteractor.appState
    
    init() {
        self.buildCurrentTheme()
    }
    
    private mutating func buildCurrentTheme() {
        let currentTheme = appState.theme
        themeSelectedIndex = currentTheme != .unspecified ? currentTheme.rawValue-1 : 0
        
        print("currentTheme.rawValue == \(currentTheme.rawValue)")
        print("themeSelectedIndex == \(themeSelectedIndex)")

    }
    
    func setTheme(_ index: Int) {
        let newTheme: UIUserInterfaceStyle = index == 0 ? .light : .dark
        appState.setTheme(newTheme)
        print("did setTheme to \(newTheme.rawValue)")
    }
}
