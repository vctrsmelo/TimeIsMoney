//
//  Weekday.swift
//  Time is Money
//
//  Created by Victor Melo on 17/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

struct WeekdayView: View {

    @EnvironmentObject var appState: AppState
    @Environment(\.interactors) var interactors: InteractorsContainer

    private let weekday: Weekday
    private var isSelected: Bool {
        return appState.user.workdays.contains(weekday)
    }
    
    init(_ weekday: Weekday) {
        self.weekday = weekday
    }
    
    var body: some View {
        let color = DesignSystem.color
        let backgroundColor = isSelected ? color.enabled.asColor : color.disabled.asColor
        
        return ZStack {
            Circle()
                .foregroundColor(backgroundColor)
            Button(action: {
                if self.isSelected {
                    self.appState.user.workdays.removeAll { $0 == self.weekday }
                } else {
                    self.appState.user.workdays.append(self.weekday)
                }
            }) {
                Text(self.weekday.localized())
                    .font(DesignSystem.font.bold(size: .h4).asFont)
                    .foregroundColor(Color.white)
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            }
            
        }
//        .frame(width: 40, height: 40, alignment: .center)
    }
}

struct WeekdayView_Previews: PreviewProvider {
    static var previews: some View {
        WeekdayView(Weekday.monday)
    }
}
