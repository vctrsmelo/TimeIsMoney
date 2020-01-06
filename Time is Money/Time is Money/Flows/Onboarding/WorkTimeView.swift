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
    
    @State private var selectedHours: Int = 39
    
    var hours = (1...168).map { "\($0)"}
    
    var body: some View {
        
        return Group {
            VStack {
                Text("How much hours do you work per week?")
                    .font(Design.Font.Title.smallTitleFont)
                    .foregroundColor(Design.Color.Text.title)
                    .padding(.bottom, 26)
                    .padding(.top, 43)
                Image("table2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width/1.6)
                Text("\(hours[selectedHours])")
                    .font(Design.Font.Title.largeTitleFont)
                    .foregroundColor(Design.Color.Text.standard)
                    .padding(.bottom, 6)
                Text("Hours per week")
                    .font(Design.Font.subtitle)
                    .foregroundColor(Design.Color.Text.standard)
                    .padding(.bottom, 14)
                Section {
                    Picker(selection: $selectedHours, label: EmptyView()) {
                        ForEach(0 ..< hours.count) {
                            Text(self.hours[$0]+" hours").tag($0)

                        }
                    }
                    .foregroundColor(Design.Color.Text.standard)
                    .pickerStyle(WheelPickerStyle())
                    .labelsHidden()
                    
                }
                .background(Color.clear)
                Spacer()
            }
        }.withBackground()
            .onDisappear(perform: {
                self.user.weeklyWorkHours = self.selectedHours+1
            })
        .onAppear {
            self.selectedHours = self.user.weeklyWorkHours-1
        }
    }
}

struct WorkTimeView_Previews: PreviewProvider {
    static var previews: some View {
        WorkTimeView()
    }
}
