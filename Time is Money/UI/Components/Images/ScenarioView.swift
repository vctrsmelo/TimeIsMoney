//
//  ScenarioView.swift
//  Time is Money
//
//  Created by Victor Melo on 08/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

struct Scenario {
    
    let workplace: Image
    let avatarView: AvatarView
    let avatarXOffset: CGFloat
    let avatarYOffset: CGFloat
    let avatarViewScale: CGFloat
    
    var workplaceWidth: CGFloat {
        return 435
    }
}

struct ScenarioView: View {
    
    let scenario: Scenario
    
    init(scenario: Scenario) {
        self.scenario = scenario
    }
    
    var body: some View {
        ZStack {
            scenario.avatarView
                .scaleEffect(0.5)
                .offset(x: 20, y: -100)
            scenario.workplace
        }
    }
}

struct ScenarioView_Previews: PreviewProvider {
    static var previews: some View {
        
        let scenario = ScenarioFactory.officeScenarios(avatar: AvatarFactory.female2()).first!
        
        return ForEach(Self.supportedLocales, id:\.self) { locale in
            ScenarioView(scenario: scenario).environment(\.locale, locale)
        }
    }
}
