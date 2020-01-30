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
    
    var hours = (0...100).map { "\($0)"}
    
    var body: some View {
        
        let selectedHours = Binding(
            get: { self.user.weeklyWorkHours },
            set: { self.user.weeklyWorkHours = $0 }
        )
    
        let hoursArrayIndex = max(0, min(hours.count-1,selectedHours.wrappedValue))
        
        return Group {
            VStack {
                Text("How many hours do you work?")
                    .font(Design.Font.Title.customTitleFont(size: 30))
                    .foregroundColor(Design.Color.Text.title)
                Image("table2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width-120, alignment: .center)
                    .frame(minHeight: 150, alignment: .center)
                    .animation(.none)
                Text("\(hours[hoursArrayIndex])")
                    .font(Design.Font.Title.largeTitleFont)
                    .foregroundColor(Design.Color.Text.standard)
                    .padding(.bottom, 6)
                Text("Hours per week")
                    .font(Design.Font.subtitle)
                    .foregroundColor(Design.Color.Text.standard)
                maybePickerSection(selectedHours: selectedHours)
                Spacer()
            }
        }.withBackground()
    }
    
    private func maybePickerSection(selectedHours: Binding<Int>) -> some View {
        guard user.workdays.isEmpty == false else {
            return
                AnyView(
                        Text("(Set your workdays to update here)")
                            .font(Design.Font.smallLight)
                            .foregroundColor(Design.Color.Text.standard)
                )
        }
            
        return AnyView(
            Section {
                Picker(selection: selectedHours, label: EmptyView()) {
                    ForEach(0 ..< self.hours.count) {
                        Text(self.hours[$0]+" "+"hours".localized)
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
        return ForEach(Self.supportedLocales, id: \.identifier) { locale in
            WorkTimeView()
                
        }
    }
}
