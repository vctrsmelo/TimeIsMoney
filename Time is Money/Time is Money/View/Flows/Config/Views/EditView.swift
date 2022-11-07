//
//  EditView.swift
//  Time is Money
//
//  Created by Victor Melo on 14/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI
import UIKit

struct EditView: View {
    
    @EnvironmentObject var appState: AppState
    @Environment(\.interactors) var interactors: InteractorsContainer
    
    private let hours = (0...168).map { "\($0)"}
    
    @State private var moneyPerHour: NSNumber = 0.0
    @State private var showingAlert = false
    
    private var moneyPerHourFormatted: String {
        return Formatter.currency.string(from: moneyPerHour) ?? ""
    }
    
    var body: some View {
        
        let weeklyWorktime = R.string.localizable.weeklyWorktime()
        let weeklyWorkdays = R.string.localizable.weeklyWorkdays()
        let monthlyIncome = R.string.localizable.monthlyIncome()
        
        return NavigationView {
            VStack {
                Form {
                    Section(header: EmptyView(), footer: avatarSection) {
                        EditFieldView(title: weeklyWorktime, icon: Image("MoneyClockIcon"), inputView: AnyView(worktimePicker))
                        EditFieldView(title: weeklyWorkdays, icon: Image("CalendarIcon"), inputView: AnyView(weekdays))
                        EditFieldView(title: monthlyIncome, icon: Image("MoneyIcon"), inputView: AnyView(salaryField))
                    }
                }
            }
            .withBackground()
            .gesture(DragGesture()
                .onChanged { value in
                    self.hideKeyboard()
                }
            )
        }.onDisappear {
            self.interactors.mainInteractor.saveAppState()
        }

    }
    
    private var avatarSection: some View {
        VStack {
            Text(R.string.localizable.avatar())
                .multilineTextAlignment(.center)
                .font(config.font.light(size: .body).swiftUIFont)
                .foregroundColor(config.color.complementaryColor.swiftUIColor)
                .animation(.none)
            HAvatarPickerView(buttonWidth: (UIScreen.main.bounds.width/4 <= 100) ? UIScreen.main.bounds.width/4 : 100)
        }
    }
    
    private var worktimePicker: some View {
        
        let selectedHours = Binding(
            get: { return self.appState.user.weeklyWorkHours },
            set: { self.appState.user.weeklyWorkHours = $0 }
        )
        
       return Picker(selection: selectedHours, label: EmptyView()) {
            ForEach(0 ..< hours.count, id: \.self) {
                Text(self.hours[$0]+" "+R.string.localizable.hours())
                    .font(config.font.regular(size: .body).swiftUIFont)
                    .foregroundColor(self.appState.user.isSelectedHoursValid($0) ? config.color.disabledColor.swiftUIColor : config.color.complementaryColor.swiftUIColor)
            }
        }
        .labelsHidden()
    }
    
    private var weekdays: some View {
        let weekdays = self.appState.user.workdays.sortedWeekdays().map { $0.localizedMedium() }.reduce("") { (result, newVal) -> String in
           return result+"\(newVal), "
        }.dropLast(2)
        
        let view = (weekdays == "") ? Text("No workday") : Text(weekdays)
        
        return NavigationLink(destination: WeekdaySelectionListView()) {
            view
            .font(config.font.regular(size: .body).swiftUIFont)
        }
    }
    
    private var salaryField: some View {
        
        let salaryBinding = Binding(
            get: { self.appState.user.monthlySalary },
            set: { self.appState.user.monthlySalary = $0 }
       )
        
        return CurrencyField(salaryBinding, placeholder: "", font: config.font.regular(size: .body).uiKitFont, textAlignment: NSTextAlignment.left)
    }
    
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView()
    }
}

// MARK: - Other Views

struct WeekdaySelectionListView: View {
    
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
    
    @EnvironmentObject var appState: AppState
    @Environment(\.interactors) var interactors: InteractorsContainer
    
    private let weekday: Weekday
    
    init(_ weekday: Weekday) {
        self.weekday = weekday
    }
    
    var body: some View {
        
        let isSelected = self.appState.user.workdays.contains(self.weekday)
        let checkmarkColor = (isSelected) ?  Color(.blue) : Color(.gray)

        return HStack {
            Text(weekday.localizedLong())
                .font(config.font.light(size: .body).swiftUIFont)
                .foregroundColor(config.color.complementaryColor.swiftUIColor)
            Spacer()
            Image(systemName: "checkmark").foregroundColor(checkmarkColor)
        }
        .listRowBackground(config.color.primaryColor.swiftUIColor)
        .contentShape(Rectangle())
        .onTapGesture {
            if self.appState.user.workdays.contains(self.weekday) {
                self.appState.user.workdays.removeAll { $0 == self.weekday }
            } else {
                self.appState.user.workdays.append(self.weekday)
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
                        .font(config.font.light(size: .h4).swiftUIFont)
                    Spacer()
                }.padding(.bottom, -10)
                
                inputView
            }
            .foregroundColor(config.color.complementaryColor.swiftUIColor)
        }
        .listRowBackground(config.color.primaryColor.swiftUIColor)
    }
}
