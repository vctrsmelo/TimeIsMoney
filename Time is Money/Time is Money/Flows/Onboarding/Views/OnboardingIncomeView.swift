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
    
    var incomeBinding: Binding<NSDecimalNumber> {
        Binding(
            get: { self.appState.user.monthlySalary },
            set: { self.appState.user.monthlySalary = $0 }
        )
    }
    
    init() {
        UITableView.appearance().tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        UITableView.appearance().tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(R.string.localizable.whatIsYourIncome())
                .padding(.top, 20)
                .font(config.font.bold(size: .title).swiftUIFont)
                .foregroundColor(config.color.complementaryColor.swiftUIColor)
                .frame(maxWidth: .infinity, maxHeight:80)
            
            Spacer()
            
            Image("Money_img")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width-120, alignment: .center)
                .frame(minHeight: 100, alignment: .center)
                .animation(.none)
            
            Spacer()
            
            CurrencyField(incomeBinding, placeholder: "Income")
                .frame(width: UIScreen.main.bounds.width, height: 60, alignment: .center)
            
            Text("per month")
                .font(config.font.light(size: .body).swiftUIFont)
                .foregroundColor(config.color.complementaryColor.swiftUIColor)
            
            Spacer()
            
            FinishButton()
            
            Spacer()
        }
        .withBackground()
        .navigationBarHidden(true)
    }
}

struct FinishButton: View {
    
    @EnvironmentObject var appState: AppState
    @Environment(\.interactors) var interactors: InteractorsContainer
    @State private var action: Int? = 0
    
    var body: some View {
        VStack {
            NavigationLink(destination: MainView().environmentObject(appState), tag: 1, selection: $action) { EmptyView() }
            Text("Finish")
                .font(config.font.semibold(size: .body).swiftUIFont)
                .frame(width: 200, height: 50, alignment: .center)
                .background(config.color.complementaryColor.swiftUIColor)
                .foregroundColor(config.color.primaryColor.swiftUIColor)
                .cornerRadius(5)
                .onTapGesture {
                    appState.user.isOnboardingCompleted = true
                    interactors.mainInteractor.saveAppState()
                    action = 1
                }
        }
    }
}

struct IncomeView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingIncomeView()
    }
}
