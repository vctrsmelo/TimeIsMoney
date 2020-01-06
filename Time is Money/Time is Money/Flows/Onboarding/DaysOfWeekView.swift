//
//  DaysOfWeekView.swift
//  Time is Money
//
//  Created by Victor Melo on 04/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

enum Weekday {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    
    func localized() -> String {
        switch self {
        case .monday:
            return "M"
        case .tuesday, .thursday:
            return "T"
        case .wednesday:
            return "W"
        case .friday:
            return "F"
        case .saturday, .sunday:
            return "S"
        }
    }
    
    func localizedLong() -> String {
        switch self {
        case .monday:
            return "Monday"
        case .tuesday:
            return "Tuesday"
        case .wednesday:
            return "Wednesday"
        case .thursday:
            return "Thursday"
        case .friday:
            return "Friday"
        case .saturday:
            return "Saturday"
        case .sunday:
            return "Sunday"
        }
    }
    
    static func all() -> [Weekday] {
        return [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday]
    }
}

struct WeekdayView: View {

    @EnvironmentObject var settings: UserSettings

    private let weekday: Weekday
    private var isSelected: Bool {
        return settings.weekdays.contains(weekday)
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
                if self.settings.weekdays.contains(self.weekday) {
                    self.settings.weekdays.remove(self.weekday)
                } else {
                    self.settings.weekdays.insert(self.weekday)
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
    
    @EnvironmentObject var settings: UserSettings
    
    private var workdays: String {
        let weekdays = Weekday.all()
        var result = ""
        for day in weekdays {
            if settings.weekdays.contains(day) {
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
    
    static var settings = UserSettings()
    
    static var previews: some View {
        DaysOfWeekView().environmentObject(settings)
    }
}
