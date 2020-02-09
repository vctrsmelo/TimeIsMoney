//
//  ContentView.swift
//  Time is Money
//
//  Created by Victor S Melo on 10/10/19.
//  Copyright © 2019 Victor S Melo. All rights reserved.
//

import SwiftUI
import UIKit
import Rswift

struct MainView: View {
    
    @EnvironmentObject var appState: AppState
    @Environment(\.interactors) var interactors: InteractorsContainer
    
    @State private var offsetValue: CGFloat = 0.0
    @State private var showEditView = false
    @State private var topTextPadding: CGFloat = 0.0
    @State private var isKeyboardVisible = false
    
    var body: some View {
        
        let value = appState.getCurrentValue()
        
        let formattedValue = Formatter.currency.string(from: appState.currentPrice) ?? "?"
        
        let timeMessage: String
        let priceAsSeconds: TimeInterval
        
        if let calculatedPrice = value.getAsTimeInSeconds() {
            priceAsSeconds = calculatedPrice
            timeMessage = TimeTextTranslator.getWorkTimeDescriptionToPay(for: priceAsSeconds, user: appState.user)
        } else {
            priceAsSeconds = 0.0
            timeMessage = "¯\\_(ツ)_/¯"
        }
        
        let priceBinding = Binding(
            get: { self.appState.currentPrice.decimalValue },
            set: { self.appState.currentPrice = NSDecimalNumber(decimal: $0) }
        )
        
        return VStack(alignment: .center, spacing: 0) {
            HStack(spacing: 0) {
                Spacer()
                VStack(alignment: .trailing, spacing: 0) {
                    Button(action: {
                        self.showEditView.toggle()
                    }) {
                        Image(systemName: "gear")
                            .imageScale(.large)
                            .foregroundColor(Design.Color.Text.standard)
                            .frame(width: 60, height: 60)
                    }
                    .padding(.trailing, 8)

                }

            }.frame(width: UIScreen.main.bounds.width, height: 60)
            .isHidden(isKeyboardVisible)


            HStack {
                headerTextSection(timeMessage: timeMessage, formattedValue: formattedValue, priceAsSeconds: priceAsSeconds)
            }

            Spacer()

            HStack {
                workplaceImageSection()
            }

            Spacer()

            HStack {
                inputSection(priceBinding: priceBinding)
            }

        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .sheet(isPresented: $showEditView) {
            EditView().environmentObject(self.appState)
        }
        .frame(width: UIScreen.main.bounds.width, alignment: .center)
        .keyboardSensible($offsetValue, type: .paddingAndOffset, onAppearKeyboardCustom: {
            self.topTextPadding = -UIScreen.main.bounds.height/12
            self.isKeyboardVisible = true
        }, onHideKeyboardCustom: {
            self.topTextPadding = 0
            self.isKeyboardVisible = false
        })
        .onAppear() {
            if self.appState.user.isOnboardingCompleted == false {
                self.appState.user.isOnboardingCompleted.toggle()
            }
            self.interactors.mainInteractor.saveAppState()
        }
    }
    
    private func headerTextSection(timeMessage: String, formattedValue: String, priceAsSeconds: TimeInterval) -> some View {
        VStack {
            Text("It will take")
                .multilineTextAlignment(.center)
                .font(Design.Font.standardLight)
                .foregroundColor(Design.Color.Text.standard)
                .animation(.none)
            Text("\(timeMessage)")
                .lineLimit(nil)
                .font(Design.Font.Title.customTitleFont(size: 25))
                .foregroundColor(Design.Color.Text.standard)
                .multilineTextAlignment(.center)
                .animation(.none)
                .padding(.top, 10)
                .frame(minHeight: 80)
    
            getExpectedWorkingTimeText(priceAsSeconds: priceAsSeconds)
                .font(Design.Font.standardLight)
                .foregroundColor(Design.Color.Text.standard)
                .padding(.top, 10)
            Group {
                Text("to pay only those")
                    .multilineTextAlignment(.center)
                    .font(Design.Font.standardLight)
                    .foregroundColor(Design.Color.Text.standard)
                    .animation(.none)
                    .padding(.top, 10)
                Text("\(formattedValue)")
                    .font(Design.Font.subtitle)
                    .foregroundColor(Design.Color.Text.standard)
                    .padding(.top, 10)
            }
            .isHidden(isKeyboardVisible)
        }
    }
    
    private func getExpectedWorkingTimeText(priceAsSeconds: TimeInterval) -> Text {
        let priceNormalizedToWorkTime = TimeTextTranslator.getNormalizedWorkTimeFrom(priceAsSeconds: NSDecimalNumber(value: priceAsSeconds), user: appState.user)
        guard let routine = TimeTextTranslator.getWorkRoutineDescriptionToPay(for: priceNormalizedToWorkTime, dailyWorkHours: appState.user.dailyWorkHours, weeklyWorkDays: appState.user.workdays.count) else {
            return Text("")
        }
        
        let seconds = routine.value * NSDecimalNumber(value: 1.hourInSeconds)
        guard let routineHoursAndMinutes = Formatter.hoursAndMinutes(seconds: seconds.doubleValue) else {
            return Text("")
        }
        
        switch routine.period {
        case .weekly:
            return Text(R.string.localizable.working()+" \(routineHoursAndMinutes) "+R.string.localizable.perWeek())
        case .daily:
            return Text(R.string.localizable.working()+" \(routineHoursAndMinutes) "+R.string.localizable.perDay())
        }
    }
    
    private func workplaceImageSection() -> some View {
        let avatar = AvatarFactory.getById(id: appState.avatarId)
        let scenarios = ScenarioFactory.getAllScenarios(for: .office, avatar: avatar)
        return ScenarioFactory.getScenario(from: scenarios, price: appState.currentPrice, user: appState.user)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: UIScreen.main.bounds.width-120, alignment: .center)
            .frame(minHeight: 50, alignment: .center)
            .animation(.none)
    }
    
    private func inputSection(priceBinding: Binding<Decimal>) -> some View {
        
        let width = UIScreen.main.bounds.width - (UIDevice.current.hasHomeButton ? 0 : 16)
        let cornerRadius: CGFloat = UIDevice.current.hasHomeButton ? 0 : 100
        let keyboardVisibleOffset: CGFloat = UIDevice.current.hasHomeButton ? 0 : -16
        
        let income = R.string.localizable.income()
        
        return VStack {
            Text("Type below the price")
                .font(Design.Font.smallLight)
                .foregroundColor(Design.Color.Text.standard)
                .isHidden(isKeyboardVisible)

            CurrencyField(priceBinding, placeholder: income, textColor: .white)
                .background(Color(.sRGB, red: 94/255.0, green: 128/255.0, blue: 142/255.0, opacity: 1))
                .frame(width: width, height: 50, alignment: .center)
                .cornerRadius(cornerRadius)
        }
        .offset(x: 0, y: (isKeyboardVisible) ? keyboardVisibleOffset : 0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(Self.supportedLocales, id:\.self) { locale in
            MainView().environment(\.locale, locale)
        }
    }
}

// MARK: - Other Views

