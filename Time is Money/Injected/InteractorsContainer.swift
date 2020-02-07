//
//  InteractorsContainer.swift
//  Time is Money
//
//  Created by Victor Melo on 07/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation

struct Interactors {
    let mainInteractor: MainInteractor
    
    init(mainInteractor: MainInteractor) {
        self.mainInteractor = mainInteractor
    }
    
//    static var stub: Self {
//        .init(mainInteractor: StubMainInteractor())
//    }
}
