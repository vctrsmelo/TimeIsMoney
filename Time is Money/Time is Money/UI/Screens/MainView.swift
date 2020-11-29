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
    
    private struct MainViewModel {
        var offsetValue: CGFloat = 0.0
        var showEditView = false
        var topTextPadding: CGFloat = 0.0
        var isKeyboardVisible = false
        var isAlertShowing: Bool = false
    }
    
    @EnvironmentObject var appState: AppState
    @Environment(\.interactors) var interactors: InteractorsContainer
    
    @State private var viewModel: MainViewModel = MainViewModel()
    
    var body: some View {
        
        let value = appState.getCurrentValue()
        
        let formattedValue = Formatter.currency.string(from: appState.currentPrice) ?? "?"
        
        let timeMessage: String
        let priceAsSeconds: TimeInterval
        
        if let money = value.getAsMoney(), money < Money(value: 0.01) {
            priceAsSeconds = 0.0
            timeMessage = R.string.localizable.itSOnTheHouse🤑()
            
        } else if appState.user.dailyWorkHours <= NSDecimalNumber(value: 0.1) || appState.user.monthlySalary <= Decimal(0.01) {
            priceAsSeconds = 0.0
            timeMessage = R.string.localizable.foreverIGuess😮()
            
        } else if let calculatedPrice = value.getAsTimeInSeconds() {
            priceAsSeconds = calculatedPrice
            timeMessage = priceAsSeconds < 1 ? R.string.localizable.lessThanASecond() : TimeTextTranslator.getWorkTimeDescriptionToPay(for: priceAsSeconds, user: appState.user)
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
                        self.viewModel.showEditView.toggle()
                    }) {
                        Image(systemName: "gear")
                            .imageScale(.large)
                            .foregroundColor(config.color.complementaryColor.swiftUIColor)
                            .frame(width: 60, height: 60)
                    }

                }

            }.frame(width: UIScreen.main.bounds.width, height: 60)
            .isHidden(viewModel.isKeyboardVisible)


            HStack {
                // these parameters shouldn't be here
                headerTextSection(timeMessage: timeMessage, formattedValue: formattedValue, priceAsSeconds: priceAsSeconds)
            }
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))

            Spacer()

            HStack {
                workplaceImageSection()
            }

            Spacer()

            HStack {
                InputSectionView(priceBinding: priceBinding, isKeyboardVisible: viewModel.isKeyboardVisible)
            }

        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .sheet(isPresented: $viewModel.showEditView) {
            EditView().environmentObject(self.appState)
        }
        .frame(width: UIScreen.main.bounds.width, alignment: .center)
        .keyboardSensible($viewModel.offsetValue, type: .paddingAndOffset, onAppearKeyboardCustom: {
            self.viewModel.topTextPadding = -UIScreen.main.bounds.height/12
            self.viewModel.isKeyboardVisible = true
        }, onHideKeyboardCustom: {
            self.viewModel.topTextPadding = 0
            self.viewModel.isKeyboardVisible = false
        })
        .onAppear() {
            if self.appState.user.isOnboardingCompleted == false {
                self.appState.user.isOnboardingCompleted.toggle()
            }
            
            if self.appState.avatarId == "male2-deprecated" {
                self.viewModel.isAlertShowing = true
                self.appState.avatarId = "male2"
            }
            
            self.interactors.mainInteractor.saveAppState()
        }.alert(isPresented: $viewModel.isAlertShowing) {
            return Alert(title: Text(R.string.localizable.yayUpdate()), message: Text(R.string.localizable.nowYouCanSelectADifferentAvatarGoToSettingsScreenToSelectYours()), dismissButton: Alert.Button.default(Text("Ok")))
        }
    }
    
    // make this a view
    private func headerTextSection(timeMessage: String, formattedValue: String, priceAsSeconds: TimeInterval) -> some View {
        let isMonetaryValueZero = appState.getCurrentValue().getAsMoney() == 0.0
        
        return VStack {
            Text("It will take")
                .multilineTextAlignment(.center)
                .font(config.font.light(size: .body).swiftUIFont)
                .foregroundColor(config.color.complementaryColor.swiftUIColor)
                .animation(.none)
                .isHidden(isMonetaryValueZero)
            Text("\(timeMessage)")
                .lineLimit(nil)
                .font(config.font.bold(size: .title).swiftUIFont)
                .foregroundColor(config.color.complementaryColor.swiftUIColor)
                .multilineTextAlignment(.center)
                .animation(.none)
                .padding(.top, 10)
    
            getExpectedWorkingTimeText(priceAsSeconds: priceAsSeconds)
                .font(config.font.light(size: .body).swiftUIFont)
                .foregroundColor(config.color.complementaryColor.swiftUIColor)
                .padding(.top, 10)
                .isHidden(isMonetaryValueZero)
            Group {
                Text("to pay off these")
                    .multilineTextAlignment(.center)
                    .font(config.font.light(size: .body).swiftUIFont)
                    .foregroundColor(config.color.complementaryColor.swiftUIColor)
                    .animation(.none)
                    .isHidden(isMonetaryValueZero)
                Text("\(formattedValue)")
                    .frame(minWidth: 100, alignment: .center)
                    .font(config.font.bold(size: .subtitle).swiftUIFont)
                    .foregroundColor(config.color.complementaryColor.swiftUIColor)
                    .padding(.top, 10)
                    .isHidden(isMonetaryValueZero)
                
            }
            .isHidden(viewModel.isKeyboardVisible)
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

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(Self.supportedLocales, id:\.self) { locale in
            MainView().environment(\.locale, locale)
        }
    }
}

// MARK: - Other Views

// Create subviews private here
private struct InputSectionView: View {
    
    @Binding var priceBinding: Decimal
    
    var isKeyboardVisible: Bool
    
    var body: some View {
        let width = UIScreen.main.bounds.width - (UIDevice.current.hasHomeButton ? 0 : 16)
               let cornerRadius: CGFloat = UIDevice.current.hasHomeButton ? 0 : 100
               let keyboardVisibleOffset: CGFloat = UIDevice.current.hasHomeButton ? 0 : -16
               
               let income = R.string.localizable.income()
               
       return VStack {
           Text("Type below the price")
               .font(config.font.light(size: .h4).swiftUIFont)
               .foregroundColor(config.color.complementaryColor.swiftUIColor)
               .isHidden(isKeyboardVisible)

           CurrencyField($priceBinding, placeholder: income, textColor: .white)
               .background(config.color.complementaryColor.swiftUIColor)
               .frame(width: width, height: 50, alignment: .center)
               .cornerRadius(cornerRadius)
       }
       .offset(x: 0, y: (isKeyboardVisible) ? keyboardVisibleOffset : 0)
    }
}
