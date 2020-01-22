//
//  PreviewProvider+Locale.swift
//  Time is Money
//
//  Created by Victor Melo on 21/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

extension PreviewProvider {
    static var supportedLocales: [Locale] {
        [
          "en-US", // English (United States)
          "pt-BR" // Portuguese (Brazil)
        ].map(Locale.init(identifier:))
    }
}
