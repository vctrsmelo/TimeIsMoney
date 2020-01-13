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
    
    @State private var incomeValue: Decimal = 1000
    @EnvironmentObject var user: User
    @State private var offsetValue: CGFloat = 0.0
    
    init() {
        UITableView.appearance().tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        UITableView.appearance().tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        UITableView.appearance().backgroundColor = .clear
    }
    
    
    var body: some View { 
        
        return Group {
            VStack {
                Text("What is your income per month?")
                    .font(Design.Font.Title.smallTitleFont)
                    .foregroundColor(Design.Color.Text.title)
                    .padding(.bottom, 26)
                    .padding(.top, 43)
                Image("Money")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width/1.6)
                    .padding(.bottom, 80)
                CurrencyField($incomeValue, placeholder: "Income")
                    .frame(width: UIScreen.main.bounds.width, height: 60, alignment: .center)
                Text("per month")
                    .font(Design.Font.standardLight)
                    .foregroundColor(Design.Color.Text.standard)
                Spacer()
                NavigationLink(destination: MainView()) {
                    Text("Finish")
                        .font(Design.Font.standardLight)
                        .frame(width: 180, height: 30, alignment: .center)
                        .background(Design.Color.Text.standard)
                        .foregroundColor(Color.white)
                        .cornerRadius(5)
                }
                Spacer()
            }
        }.withBackground()
        .onAppear {
            self.incomeValue = Decimal(self.user.monthlySalary)
        }
        .onDisappear {
            self.user.monthlySalary = self.incomeValue.asDouble()
        }
        .keyboardSensible($offsetValue, type: .padding)
    }
}

struct IncomeView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeView()
    }
}
