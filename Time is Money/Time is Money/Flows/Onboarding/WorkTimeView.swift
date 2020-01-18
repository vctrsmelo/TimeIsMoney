//
//  WorkTimeView.swift
//  Time is Money
//
//  Created by Victor Melo on 03/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation
import SwiftUI
import TimeIsMoneyCore

struct WorkTimeView: View {
    
    @EnvironmentObject var user: User
    
    init() {
        UITableView.appearance().tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        UITableView.appearance().tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        UITableView.appearance().backgroundColor = .clear
    }
    
    var hours = (0...100).map { "\($0)"}
    
    var body: some View {
        
        let selectedHours = Binding(
            get: { self.user.weeklyWorkHours },
            set: { self.user.weeklyWorkHours = $0 }
        )
    
        let hoursArrayIndex = max(0, min(hours.count-1,selectedHours.wrappedValue))
        
        return Group {
            VStack {
                Text("How much hours do you work per week?")
                    .font(Design.Font.Title.smallTitleFont)
                    .foregroundColor(Design.Color.Text.title)
                    .padding(EdgeInsets(top: 43, leading: 16, bottom: 26, trailing: 16))
                    .multilineTextAlignment(.center)
                Image("table2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width/1.6)
                Text("\(hours[hoursArrayIndex])")
                    .font(Design.Font.Title.largeTitleFont)
                    .foregroundColor(Design.Color.Text.standard)
                    .padding(.bottom, 6)
                Text("Hours per week")
                    .font(Design.Font.subtitle)
                    .foregroundColor(Design.Color.Text.standard)
                    .padding(.bottom, 14)
                maybePickerSection(selectedHours: selectedHours)
                Spacer()
            }
        }.withBackground()
    }
    
    private func maybePickerSection(selectedHours: Binding<Int>) -> some View {
        guard user.workdays.isEmpty == false else {
            return AnyView(Text("(Set your workdays to update here)"))
        }
            
        return AnyView(
            Section {
                Picker(selection: selectedHours, label: EmptyView()) {
                    ForEach(0 ..< self.hours.count) {
                        Text(self.hours[$0]+" hours")
                            .foregroundColor(self.user.isSelectedHoursValid($0) ? Design.Color.disabled : Design.Color.Text.standard)
                    }
                }
                .foregroundColor(Design.Color.Text.standard)
                .pickerStyle(WheelPickerStyle())
                .labelsHidden()
            }
            .background(Color.clear)
        )
    }
}

struct WorkTimeView_Previews: PreviewProvider {
    static var previews: some View {
        WorkTimeView()
    }
}
