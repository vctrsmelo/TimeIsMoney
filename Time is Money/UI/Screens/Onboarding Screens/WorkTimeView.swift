//
//  WorkTimeView.swift
//  Time is Money
//
//  Created by Victor Melo on 03/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation
import SwiftUI

struct WorkTimeView: View {
    
    @EnvironmentObject var appState: AppState
    @Environment(\.interactors) var interactors: InteractorsContainer
    
    var hours = (0...100).map { "\($0)"}
    
    var body: some View {
        
        let selectedHours = Binding(
            get: { self.appState.user.weeklyWorkHours },
            set: { self.appState.user.weeklyWorkHours = $0 }
        )
    
        let hoursArrayIndex = max(0, min(hours.count-1,selectedHours.wrappedValue))
        
        return Group {
            VStack {
                Text(R.string.localizable.howManyHoursDoYouWorkPerWeek())
                    .lineLimit(nil)
                    .adaptableFont(.smallTitleFont, maxSize: 25)
                    .foregroundColor(Design.Color.Text.title)
                    .frame(maxHeight: .infinity)
                Image("table2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width-120, alignment: .center)
                    .frame(minHeight: 50, alignment: .center)
                    .animation(.none)
            
                Text("\(hours[hoursArrayIndex])")
                    .font(Design.Font.Title.smallTitleFont)
                    .foregroundColor(Design.Color.Text.standard)
                    .padding(.bottom, 6)
                Text("Hours per week")
                    .font(Design.Font.subtitle)
                    .foregroundColor(Design.Color.Text.standard)
                maybePickerSection(selectedHours: selectedHours)
                Spacer()
            }
        }.withBackground()
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    private func maybePickerSection(selectedHours: Binding<Int>) -> some View {
        guard appState.user.workdays.isEmpty == false else {
            return
                AnyView(
                        Text("(Set your workdays to update here)")
                            .font(Design.Font.smallLight)
                            .foregroundColor(Design.Color.Text.standard)
                            .multilineTextAlignment(.center)
                )
        }
        
        let hours = R.string.localizable.hours()
            
        return AnyView(
            Section {
                Picker(selection: selectedHours, label: EmptyView()) {
                    ForEach(0 ..< self.hours.count) {
                        Text(self.hours[$0]+" "+hours)
                            .foregroundColor(self.appState.user.isSelectedHoursValid($0) ? Design.Color.disabled : Design.Color.Text.standard)
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
