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
    
    @State private var worktime: Int = 39
    @State private var salary: Decimal = 0.0
    @State private var workdays = [Weekday]()
    
    @State private var isFirstAppearance: Bool = true
    
    private let hours = (1...168).map { "\($0)"}
    
    @State private var moneyPerHour: NSNumber = 0.0
    
    private var moneyPerHourFormatted: String {
        return Formatter.currency.string(from: moneyPerHour) ?? ""
    }
    
    var body: some View {
        print(worktime)
        return NavigationView {
            VStack {
                Form {
                    Section {
                        EditFieldView(title: "Horas de trabalho", icon: Image("MoneyClockIcon"), inputView: AnyView(worktimePicker))
                        EditFieldView(title: "Dias de trabalho semanal", icon: Image("CalendarIcon"), inputView: AnyView(weekdays))
                        EditFieldView(title: "Salário Mensal", icon: Image("MoneyIcon"), inputView: AnyView(salaryField))
                    }
                    
                    Section(header: Text("Interesting Information")) {
                        Text("Per work hour you receive: \(moneyPerHourFormatted)")
                        .listRowBackground(Design.Color.Background.standard)
                    }
                }
            }
            .withBackground()
            .gesture(DragGesture()
                .onChanged { value in
                    self.hideKeyboard()
                }
            )
            .onReceive(user.$monthlySalary, perform: { output in
                print("onReceive salary: \(self.user.monthlySalary.asDecimal())")
                self.worktime = self.user.weeklyWorkHours
                self.salary = self.user.monthlySalary.asDecimal()
                self.workdays = self.user.workdays
            })
//            .onAppear() {
//                if self.isFirstAppearance {
//                    self.worktime = self.user.weeklyWorkHours
//                    self.salary = self.user.monthlySalary.asDecimal()
//                    self.workdays = self.user.workdays
//                    print("appear self salary: \(self.salary)")
//                }
//                 self.isFirstAppearance = false
//            }
            .onDisappear {
                print("disappear self salary: \(self.salary)")
                self.user.weeklyWorkHours = self.worktime
                self.user.monthlySalary = self.salary.asDouble()
                self.user.workdays = self.workdays
                print("disappear user salary: \(self.user.monthlySalary)")
            }
        }
    }
    
    private var worktimePicker: some View {
        Picker(selection: $worktime, label: EmptyView()) {
            ForEach(0 ..< hours.count) {
                Text(self.hours[$0]+" hours")
                    .font(Design.Font.standardRegular)

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
        return CurrencyField($salary, placeholder: "", font: Design.UIFont.standardRegular, textAlignment: NSTextAlignment.left)
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

        if isSelected {
            print("Selected")
        }
        return HStack {
            Text(weekday.localizedLong())
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