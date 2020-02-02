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
                result +=  "\(day.localizedLong()), "
            }
        }
        return "\(result.dropLast(2))"
    }
    
    var body: some View {
        
        GeometryReader { g in
            VStack(spacing: 0) {
                
                HStack {
                    Text("Which days of the week do you usually work?")
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                        .lineLimit(nil)
                        .adaptableFont(.smallTitleFont, maxSize: 30)
                        .foregroundColor(Design.Color.Text.title)
                        .background(Color.red)
                }.frame(maxHeight: g.size.height/4)

                Spacer()
                
                HStack {
                    Image("Calendar_img")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width/2)
                        .background(Color.yellow)
                }
                
                Spacer()
                
                HStack {
                    ForEach(Weekday.all(), id: \.self) {
                        WeekdayView($0)
                    }
                }
                .background(Color.green)
                
                Spacer()
                
                Text(self.workdays)
                    .font(Design.Font.smallRegular)
                    .foregroundColor(Design.Color.Text.standard)
        
        }
        .withBackground()
        .navigationBarTitle("")
        .navigationBarHidden(true)
        }
    }
}

struct DaysOfWeekView_Previews: PreviewProvider {
    
    static var user = User()
    
    static var previews: some View {
        
        return ForEach(Self.supportedLocales, id: \.identifier) { locale in
            DaysOfWeekView()
                .environmentObject(user)
                .environment(\.locale, locale)
                
        }
    }
}
