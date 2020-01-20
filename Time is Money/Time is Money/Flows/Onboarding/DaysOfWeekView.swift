//
//  DaysOfWeekView.swift
//  Time is Money
//
//  Created by Victor Melo on 04/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI
import TimeIsMoneyCore

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
