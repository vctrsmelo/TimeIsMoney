//
//  DaysOfWeekView.swift
//  Time is Money
//
//  Created by Victor Melo on 04/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI
import TimeIsMoneyCore

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

struct DaysOfWeekView: View {
    
    @EnvironmentObject var user: User
    
    private var workdays: String {
        let weekdays = Weekday.all()
        var result = ""
        for day in weekdays {
            if user.workdays.contains(day) {
                result += "\(day.localizedLong()), "
            }
        }
        return "\(result.dropLast(2))"
    }
    
    var body: some View {
        
        return VStack {
            Text("Which days of the week do you usually work?")
                .font(Design.Font.Title.smallTitleFont)
                .foregroundColor(Design.Color.Text.title)
                .padding(.bottom, 26)
                .padding(.top, 43)
            Image("Calendar")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width/2)
                .padding(.bottom, 60)
            HStack {
                ForEach(Weekday.all(), id: \.self) {
                    WeekdayView($0)
                }
            }
            Spacer()
            Text(workdays)
                .font(Design.Font.smallRegular)
                .foregroundColor(Design.Color.Text.standard)
            Spacer()
        }.withBackground()
    }
}

struct DaysOfWeekView_Previews: PreviewProvider {
    
    static var user = User()
    
    static var previews: some View {
        DaysOfWeekView().environmentObject(user)
    }
}
