//
//  EditView.swift
//  Time is Money
//
//  Created by Victor Melo on 14/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI
import UIKit
import TimeIsMoneyCore

struct EditView: View {
    
    @EnvironmentObject var user: User
    
    private let hours = (0...168).map { "\($0)"}
    
    @State private var moneyPerHour: NSNumber = 0.0
    
    private var moneyPerHourFormatted: String {
        return Formatter.currency.string(from: moneyPerHour) ?? ""
    }
    
    var body: some View {
        return NavigationView {
            VStack {
                Form {
                    Section {
                        EditFieldView(title: "Weekly Worktime".localized, icon: Image("MoneyClockIcon"), inputView: AnyView(worktimePicker))
                        EditFieldView(title: "Weekly workdays".localized, icon: Image("CalendarIcon"), inputView: AnyView(weekdays))
                        EditFieldView(title: "Monthly Income".localized, icon: Image("MoneyIcon"), inputView: AnyView(salaryField))
                    }
                }
            }
            .withBackground()
            .gesture(DragGesture()
                .onChanged { value in
                    self.hideKeyboard()
                }
            )
        }
    }
    
    private var worktimePicker: some View {
        
        let selectedHours = Binding(
            get: { return self.user.weeklyWorkHours },
            set: { self.user.weeklyWorkHours = $0 }
        )
        
       return Picker(selection: selectedHours, label: EmptyView()) {
            ForEach(0 ..< hours.count) {
                Text(self.hours[$0]+" "+R.string.localizable.hours())
                    .font(Design.Font.standardRegular)
                    .foregroundColor(self.user.isSelectedHoursValid($0) ? Design.Color.disabled : Design.Color.Text.standard)
            }
        }
        .labelsHidden()
    }
    
    private var weekdays: some View {
        let weekdays = self.user.sortedWorkdays.map { $0.localizedMedium() }.reduce("") { (result, newVal) -> String in
           return result+"\(newVal), "
        }.dropLast(2)
        
        let view = (weekdays == "") ? Text("No workday") : Text(weekdays)
        
        return NavigationLink(destination: WeekdaySelectionListView()) {
            view
            .font(Design.Font.standardRegular)
        }
    }
    
    private var salaryField: some View {
        
        let salaryBinding = Binding(
            get: { self.user.monthlySalary },
            set: { self.user.monthlySalary = $0 }
       )
        
        return CurrencyField(salaryBinding, placeholder: "", font: Design.UIFont.standardRegular, textAlignment: NSTextAlignment.left)
    }
    
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView()
    }
}

// MARK: - Other Views

struct WeekdaySelectionListView: View {
    
    @EnvironmentObject var user: User
    
    private let weekdays = Weekday.all()
    
    var body: some View {
        List {
            ForEach(weekdays) { weekday -> WeekdayRowView in
                return WeekdayRowView(weekday)
            }
        }
        .withBackground()
    }
    
}

struct WeekdayRowView: View {
    
    @EnvironmentObject var user: User
    
    private let weekday: Weekday
    
    init(_ weekday: Weekday) {
        self.weekday = weekday
    }
    
    var body: some View {
        
        let isSelected = self.user.workdays.contains(self.weekday)
        let checkmarkColor = (isSelected) ?  Color(.blue) : Color(.gray)

        return HStack {
            Text(weekday.localizedLong())
                .font(Design.Font.standardLight)
                .foregroundColor(Design.Color.Text.standard)
            Spacer()
            Image(systemName: "checkmark").foregroundColor(checkmarkColor)
        }
        .listRowBackground(Design.Color.Background.standard)
        .contentShape(Rectangle())
        .onTapGesture {
            if self.user.workdays.contains(self.weekday) {
                self.user.workdays.removeAll { $0 == self.weekday }
            } else {
                self.user.workdays.append(self.weekday)
            }
        }
    }
}

struct EditFieldView: View {
    
    let title: String
    let icon: Image
    let inputView: AnyView
    
    init(title: String, icon: Image, inputView: AnyView) {
        self.title = title
        self.icon = icon
        self.inputView = inputView
    }
    
    var body: some View {
        HStack {
            icon
            VStack {
                HStack {
                    Text(title)
                        .font(Design.Font.smallLight)
                    Spacer()
                }.padding(.bottom, -10)
                
                inputView
            }
            .foregroundColor(Design.Color.Text.standard)
        }
        .listRowBackground(Design.Color.Background.standard)
    }
}
