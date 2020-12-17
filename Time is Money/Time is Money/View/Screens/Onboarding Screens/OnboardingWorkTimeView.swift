//
//  WorkTimeView.swift
//  Time is Money
//
//  Created by Victor Melo on 03/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation
import SwiftUI

struct OnboardingWorkTimeView: View {
    
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
                
                Spacer()
                
                Text("How many hours do you work per week?")
                    .lineLimit(nil)
                    .font(DesignSystem.font.bold(size: .title).asFont)
                    .foregroundColor(DesignSystem.color.complementary.asColor)
                    .padding(.leading, DSSpacing.xl)
                    .padding(.trailing, DSSpacing.xl)
                
                Spacer()
                
                Image("office_\(appState.avatarId)_table2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width - DSSpacing.xxxl, alignment: .center)
                    .frame(minHeight: 50, alignment: .center)
                    .animation(.none)
                
                Spacer()
            
                Text("\(hours[hoursArrayIndex])")
                    .font(DesignSystem.font.bold(size: .title).asFont)
                    .foregroundColor(DesignSystem.color.complementary.asColor)
                    .padding(.bottom, 6)
                Text("Hours per week")
                    .font(DesignSystem.font.bold(size: .title).asFont)
                    .foregroundColor(DesignSystem.color.complementary.asColor)
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
                            .font(DesignSystem.font.light(size: .h4).asFont)
                        .foregroundColor(DesignSystem.color.complementary.asColor)
                            .multilineTextAlignment(.center)
                )
        }
        
        let hours = "hours"
            
        return AnyView(
            Section {
                Picker(selection: selectedHours, label: EmptyView()) {
                    ForEach(0 ..< self.hours.count) {
                        Text(self.hours[$0]+" "+hours)
                            .foregroundColor(self.appState.user.isSelectedHoursValid($0) ? DesignSystem.color.disabled.asColor : DesignSystem.color.complementary.asColor)
                    }
                }
                .foregroundColor(DesignSystem.color.complementary.asColor)
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
            OnboardingWorkTimeView()
                
        }
    }
}
