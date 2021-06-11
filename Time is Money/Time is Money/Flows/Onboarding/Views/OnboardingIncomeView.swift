//
//  IncomeView.swift
//  Time is Money
//
//  Created by Victor Melo on 03/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

struct OnboardingIncomeView: View {
    
    @EnvironmentObject var appState: AppState
    @Environment(\.interactors) var interactors: InteractorsContainer

    @State private var offsetValue: CGFloat = 0.0
    
    init() {
        UITableView.appearance().tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        UITableView.appearance().tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        let incomeBinding = Binding(
            get: { self.appState.user.monthlySalary },
            set: { self.appState.user.monthlySalary = $0 }
        )
        
        return Group {
            VStack {
                
                Spacer()
                
                HStack {
                    Text(R.string.localizable.whatIsYourIncome())
                        .padding(.top, 20)
                        .font(config.font.bold(size: .title).swiftUIFont)
                        .foregroundColor(config.color.complementaryColor.swiftUIColor)
                        .frame(maxWidth: .infinity, maxHeight:80)
                }
                
                Spacer()
                
                HStack {
                    Image("Money_img")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width-120, alignment: .center)
                        .frame(minHeight: 100, alignment: .center)
                        .animation(.none)
                }
                
                Spacer()
                
                HStack {
                    CurrencyField(incomeBinding, placeholder: "Income")
                        .frame(width: UIScreen.main.bounds.width, height: 60, alignment: .center)
                }
                
                HStack {
                    Text("per month")
                        .font(config.font.light(size: .body).swiftUIFont)
                        .foregroundColor(config.color.complementaryColor.swiftUIColor)
                }
                
                Spacer()
                
                HStack {
                    NavigationLink(destination: MainView().environmentObject(self.appState)) {
                        Text("Finish")
                            .font(config.font.semibold(size: .body).swiftUIFont)
                            .frame(width: 200, height: 50, alignment: .center)
                            .background(config.color.complementaryColor.swiftUIColor)
                            .foregroundColor(config.color.primaryColor.swiftUIColor)
                            .cornerRadius(5)
                    }
                }
                
                Spacer()
            }
        }
        .withBackground()
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct IncomeView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingIncomeView()
    }
}
