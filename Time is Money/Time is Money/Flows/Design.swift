//
//  Design.swift
//  Time is Money
//
//  Created by Victor Melo on 01/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

enum Design {
    
    enum Font {
        static var standardLight = SwiftUI.Font.system(size: 25, weight: .light)
        static var smallRegular = SwiftUI.Font.system(size: 20, weight: .regular)
        static var subtitle = SwiftUI.Font.system(size: 25, weight: .regular)
        
        enum Title {
            static var largeTitleFont = SwiftUI.Font.system(size: 50, weight: .heavy)
            static var smallTitleFont = SwiftUI.Font.system(size: 30, weight: .heavy)
        }

    }
    
    enum Color {
        
        enum Background {
            static var standard = SwiftUI.Color(.sRGB, red: 255/255.0, green: 254/255.0, blue: 240/255.0, opacity: 1)
            static var selectedOption = SwiftUI.Color(.sRGB, red: 234/255.0, green: 117/255.0, blue: 48/255.0, opacity: 1)
            static var unselectedOption = SwiftUI.Color(.sRGB, red: 120/255.0, green: 120/255.0, blue: 120/255.0, opacity: 1)
        }

        enum Text {
            static var title = SwiftUI.Color(.sRGB, red: 66/255.0, green: 94/255.0, blue: 106/255.0, opacity: 1)
            static var standard = SwiftUI.Color(.sRGB, red: 75/255.0, green: 105/255.0, blue: 118/255.0, opacity: 1)
        }
    }
    
}

extension Design {
    enum UIFont {
        enum Title {
            static var largeTitleFont = UIKit.UIFont.systemFont(ofSize: 50, weight: .heavy)
            static var smallTitleFont = UIKit.UIFont.systemFont(ofSize: 30, weight: .heavy)
        }
    }
    
    enum UIColor {
    
        enum Text {
            static var title = UIKit.UIColor(red: 66/255.0, green: 94/255.0, blue: 106/255.0, alpha: 1)
            static var standard = UIKit.UIColor(red: 75/255.0, green: 105/255.0, blue: 118/255.0, alpha: 1)
        }
    
    }
}
