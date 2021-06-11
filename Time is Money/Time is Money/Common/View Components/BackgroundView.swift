//
//  BackgroundView.swift
//  Time is Money
//
//  Created by Victor Melo on 03/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

struct BackgroundView: View {
    
    var backgroundColor: Color
    
    init(_ backgroundColor: Color = GlobalConfiguration.configuration.color.primaryColor.swiftUIColor) {
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        Rectangle()
        .foregroundColor(.clear)
        .background(backgroundColor)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            self.endEditing()
            }
        }

    private func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
