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
                    .font(config.font.bold(size: .title).swiftUIFont)
                    .foregroundColor(config.color.complementaryColor.swiftUIColor)
                    .frame(maxHeight: .infinity)
                Image("office_\(appState.avatarId)_table2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width-120, alignment: .center)
                    .frame(minHeight: 50, alignment: .center)
                    .animation(.none)
            
                Text("\(hours[hoursArrayIndex])")
                    .font(config.font.bold(size: .title).swiftUIFont)
                    .foregroundColor(config.color.complementaryColor.swiftUIColor)
                    .padding(.bottom, 6)
                Text("Hours per week")
                    .font(config.font.bold(size: .title).swiftUIFont)
                    .foregroundColor(config.color.complementaryColor.swiftUIColor)
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
                            .font(config.font.light(size: .h4).swiftUIFont)
                        .foregroundColor(config.color.complementaryColor.swiftUIColor)
                            .multilineTextAlignment(.center)
                )
        }
        
        let hours = R.string.localizable.hours()
            
        return AnyView(
            Section {
                Picker(selection: selectedHours, label: EmptyView()) {
                    ForEach(0 ..< self.hours.count) {
                        Text(self.hours[$0]+" "+hours)
                            .foregroundColor(self.appState.user.isSelectedHoursValid($0) ? config.color.disabledColor.swiftUIColor : config.color.complementaryColor.swiftUIColor)
                    }
                }
                .foregroundColor(config.color.complementaryColor.swiftUIColor)
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
