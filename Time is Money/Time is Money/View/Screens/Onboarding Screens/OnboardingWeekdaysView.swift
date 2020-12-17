//
//  DaysOfWeekView.swift
//  Time is Money
//
//  Created by Victor Melo on 04/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

struct OnboardingWeekdaysView: View {
    
    @EnvironmentObject var appState: AppState
    @Environment(\.interactors) var interactors: InteractorsContainer
    
    private var workdays: String {
        let weekdays = Weekday.all()
        var result = ""
        for day in weekdays {
            if appState.user.workdays.contains(day) {
                result +=  "\(day.localizedLong()), "
            }
        }
        return "\(result.dropLast(2))"
    }
    
    var body: some View {
        
        GeometryReader { g in
            VStack(spacing: 0) {
                
                Spacer()
                
                HStack {
                    Text("Which days of the week do you usually work?")
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                        .lineLimit(nil)
                        .font(DesignSystem.font.bold(size: .title).asFont)
                        .foregroundColor(DesignSystem.color.complementary.asColor)
                }
                
                Spacer()
                
                HStack {
                    Image("Calendar_img")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width/2.5)
                        .padding(.bottom, 30)
                }
                
                Spacer()
                
                HStack {
                    ForEach(Weekday.all(), id: \.self) {
                        WeekdayView($0)
                    }
                }.frame(maxWidth: UIScreen.main.bounds.width-16, minHeight: 50, maxHeight: 100, alignment: .center)
                
                HStack {
                    Text(self.workdays)
                        .font(DesignSystem.font.regular(size: .h4).asFont)
                        .foregroundColor(DesignSystem.color.complementary.asColor)
                }
                
                Spacer()
        
        }
        .withBackground()
        .navigationBarTitle("")
        .navigationBarHidden(true)
        }
    }
}

struct DaysOfWeekView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        return ForEach(Self.supportedLocales, id: \.identifier) { locale in
            OnboardingWeekdaysView()
                .environmentObject(AppState())
                .environment(\.locale, locale)
                
        }
    }
}
