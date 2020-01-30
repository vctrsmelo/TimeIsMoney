//
//  IncomeView.swift
//  Time is Money
//
//  Created by Victor Melo on 03/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI
import TimeIsMoneyCore

struct IncomeView: View {
    
    @EnvironmentObject var user: User

    @State private var offsetValue: CGFloat = 0.0
    @State private var topTextPadding: CGFloat = 0.0
    
    init() {
        UITableView.appearance().tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        UITableView.appearance().tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        UITableView.appearance().backgroundColor = .clear
    }
    
    
    var body: some View {
        
        let incomeBinding = Binding(
            get: { self.user.monthlySalary },
            set: { self.user.monthlySalary = $0 }
        )
        
        return Group {
            VStack {
                Text(R.string.localizable.whatIsYourIncome())
                    .font(Design.Font.Title.smallTitleFont)
                    .foregroundColor(Design.Color.Text.title)
                    .offset(x: 0, y: topTextPadding)
                Spacer()
                Image("Money")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width-120, alignment: .center)
                    .frame(minHeight: 100, alignment: .center)
                    .animation(.none)
                Spacer()
                CurrencyField(incomeBinding, placeholder: "Income")
                    .frame(width: UIScreen.main.bounds.width, height: 60, alignment: .center)
                Text("per month")
                    .font(Design.Font.standardLight)
                    .foregroundColor(Design.Color.Text.standard)
                Spacer()
                NavigationLink(destination: MainView()) {
                    Text("Finish")
                        .font(Design.Font.standardLight)
                        .frame(width: 200, height: 50, alignment: .center)
                        .background(Design.Color.Text.standard)
                        .foregroundColor(Color.white)
                        .cornerRadius(5)
                
                }
                Spacer()
            }
        }.withBackground()
        .keyboardSensible($offsetValue, type: .paddingAndOffset, onAppearKeyboardCustom: {
            self.topTextPadding = -UIScreen.main.bounds.height/16
        }, onHideKeyboardCustom: {
            self.topTextPadding = 0
        })
    }
}

struct IncomeView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeView()
    }
}
