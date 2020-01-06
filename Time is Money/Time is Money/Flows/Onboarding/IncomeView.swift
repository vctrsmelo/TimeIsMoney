//
//  IncomeView.swift
//  Time is Money
//
//  Created by Victor Melo on 03/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

struct IncomeView: View {
    
    init() {
        UITableView.appearance().tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        UITableView.appearance().tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        UITableView.appearance().backgroundColor = .clear
    }
    
    @State private var incomeValue: Decimal? = 1000
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        Group {
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
                InOutDecimalField(label: "Income", value: $incomeValue, formatter: Formatters.currencyFormatter)
                    .frame(alignment: .center)
                    .multilineTextAlignment(.center)
                    .font(Design.Font.Title.largeTitleFont)
                    .foregroundColor(Design.Color.Text.standard)
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
        .onDisappear {
            self.settings.monthlyIncome = self.incomeValue?.asDouble() ?? 0.0
        }
    }
}

struct IncomeView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeView()
    }
}
