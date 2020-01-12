//
//  View+Extensions.swift
//  Time is Money
//
//  Created by Victor Melo on 03/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    func withBackground(_ color: Color = Design.Color.Background.standard) -> some View {
        return ZStack {
            BackgroundView(color)
            self
        }
    }
}

extension View {
    
    func keyboardSensible(_ offsetValue: Binding<CGFloat>) -> some View {
        self.padding(.top, offsetValue.wrappedValue)
            .offset(y: -offsetValue.wrappedValue)
            .animation(.spring())
            .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                
                let keyWindow = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
                
                let bottom = keyWindow?.safeAreaInsets.bottom ?? 0
                
                let value = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let height = value.height
                
                offsetValue.wrappedValue = height - bottom
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                offsetValue.wrappedValue = 0
            }
        }
    }
    
}
