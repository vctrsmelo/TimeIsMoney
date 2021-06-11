//
//  HomeNavigationBarView.swift
//  Time is Money
//
//  Created by Victor Melo on 10/06/21.
//  Copyright © 2021 Victor S Melo. All rights reserved.
//

import Foundation
import SwiftUI

struct HomeNavigationBarView: View {
    
    // Binding properties received from HomeView
    @Binding var isKeyboardVisible: Bool
    @Binding var isShowingEditView: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            VStack(alignment: .trailing, spacing: 0) {
                Button(action: {
                    isShowingEditView.toggle()
                }) {
                    Image(systemName: "gear")
                        .imageScale(.large)
                        .foregroundColor(config.color.complementaryColor.swiftUIColor)
                        .frame(width: 60, height: 60)
                }
                
            }
            
        }.frame(width: UIScreen.main.bounds.width, height: 60)
        .isHidden(isKeyboardVisible)
    }
}
