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
    
    enum AdaptableFont {
        case standardLight
        case standardRegular
        case standardMedium
        case smallRegular
        case subtitle
        
        enum Title {
            case largeTitleFont
            case smallTitleFont
            
        }
    }
    
    enum Font {
        
        static var standardLight = SwiftUI.Font.system(size: 25, weight: .light)
        static var standardRegular = SwiftUI.Font.system(size: 25, weight: .regular)
        static var standardMedium = SwiftUI.Font.system(size: 25, weight: .medium)
        
        static var smallRegular = SwiftUI.Font.system(size: 18, weight: .regular)
        static var smallLight = SwiftUI.Font.system(size: 18, weight: .light)
        
        
        static var subtitle = SwiftUI.Font.system(size: 25, weight: .regular)
        
        enum Title {
            static var largeTitleFont = customTitleFont(size: 50)
            static var smallTitleFont = customTitleFont(size: 30)
            
            static func customTitleFont(size: CGFloat) -> SwiftUI.Font {
                SwiftUI.Font.system(size: size, weight: .heavy)
            }
        }
        

    }
    
    enum Color {
        
        static var disabled = SwiftUI.Color(red: 200/255, green: 200/255, blue: 200/255)
        
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
        
        static var standardLight = UIKit.UIFont.systemFont(ofSize: 25, weight: .light)
        static var standardRegular = UIKit.UIFont.systemFont(ofSize: 25, weight: .regular)
        static var standardMedium = UIKit.UIFont.systemFont(ofSize: 25, weight: .medium)
        
        static var smallRegular = UIKit.UIFont.systemFont(ofSize: 18, weight: .regular)
        static var smallLight = UIKit.UIFont.systemFont(ofSize: 18, weight: .light)
        
        
        static var subtitle = UIKit.UIFont.systemFont(ofSize: 25, weight: .regular)
        
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


extension Design.AdaptableFont {
    func getFont(size: CGFloat) -> SwiftUI.Font {
        
        switch self {

        case .standardLight: return SwiftUI.Font.system(size: size, weight: .light)
        case .standardRegular: return SwiftUI.Font.system(size: size, weight: .regular)
        case .standardMedium: return SwiftUI.Font.system(size: size, weight: .medium)
        case .smallRegular: return SwiftUI.Font.system(size: size, weight: .regular)
        case .subtitle: return SwiftUI.Font.system(size: size, weight: .regular)
        
        }
    }
}

extension Design.AdaptableFont.Title {
    
    func getFont(size: CGFloat) -> SwiftUI.Font {
        
        switch self {

        case .largeTitleFont: return SwiftUI.Font.system(size: size, weight: .heavy)
        case .smallTitleFont: return SwiftUI.Font.system(size: size, weight: .heavy)
            
        }
    }
}
