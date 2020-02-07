//
//  InteractorsContainer.swift
//  Time is Money
//
//  Created by Victor Melo on 07/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

struct InteractorsContainer: EnvironmentKey {
    
    let mainInteractor: MainInteractor
    
    static var defaultValue: Self { Self.default }
    
    private static let `default` = Self(mainInteractor: StubMainInteractor())
}

extension EnvironmentValues {
    var interactors: InteractorsContainer {
        get { self[InteractorsContainer.self] }
        set { self[InteractorsContainer.self] = newValue }
    }
}
