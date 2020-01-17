//
//  Weekday.swift
//  Time is Money
//
//  Created by Victor Melo on 17/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

struct WeekdayView: View {

    @EnvironmentObject var user: User

    private let weekday: Weekday
    private var isSelected: Bool {
        return user.workdays.contains(weekday)
    }
    
    init(_ weekday: Weekday) {
        self.weekday = weekday
    }
    
    var body: some View {
        typealias backgrounds = Design.Color.Background
        let backgroundColor = isSelected ? backgrounds.selectedOption : backgrounds.unselectedOption
        
        return ZStack {
            Circle()
                .foregroundColor(backgroundColor)
            Button(action: {
                if self.isSelected {
                    self.user.workdays.removeAll { $0 == self.weekday }
                } else {
                    self.user.workdays.append(self.weekday)
                }
            }) {
                Text(self.weekday.localized())
                .font(Design.Font.smallRegular)
                .foregroundColor(Color.white)
            }
            
        }
        .frame(width: 40, height: 40, alignment: .center)
    }
}

struct Weekday_Previews: PreviewProvider {
    static var previews: some View {
        Weekday()
    }
}
