//
//  ContentView.swift
//  Time is Money
//
//  Created by Victor S Melo on 10/10/19.
//  Copyright © 2019 Victor S Melo. All rights reserved.
//

import SwiftUI
import TimeIsMoneyCore
import Rswift

struct MainView: View {
    
    @EnvironmentObject var user: User
    
    @State private var price: Decimal = 100
    @State private var offsetValue: CGFloat = 0.0
    @State private var showEditView = false
    @State private var topTextPadding: CGFloat = 0.0
    @State private var isKeyboardVisible = false

    private var priceAsDouble: Double {
        return (price as NSDecimalNumber?)?.doubleValue ?? 0.0
    }
    
    private let flow = Flow()
    
    var body: some View {
        
        let formattedValue = Formatter.currency.string(from: NSNumber(value: priceAsDouble)) ?? "?"
        let maybeTimeNeeded = flow.getTimeNeededToPay(for: priceAsDouble)
        let dailyWorkHours = floor(Double(user.weeklyWorkHours) / Double(user.workdays.count))
        let timeMessage: String
        
        let priceAsSeconds: Double
        switch maybeTimeNeeded {
        case .success(let worktime):
            priceAsSeconds = worktime
            timeMessage = TimeTextTranslator.getWorkTimeDescriptionToPay(for: worktime, dailyWorkHours: dailyWorkHours, weeklyWorkDays:  flow.user.workdays.count)
        case .failure(let error):
            priceAsSeconds = 0.0
            timeMessage = "¯\\_(ツ)_/¯"
            print(error)
        }
        
        let priceBinding = Binding(
            get: { self.price },
            set: { self.price = $0 }
        )
        
        return VStack {
            
            Group {
                headerTextSection(timeMessage: timeMessage, formattedValue: formattedValue, priceAsSeconds: priceAsSeconds)
                
                Spacer()
                
                tableImageSection(flow: self.flow)
            }
            .offset(x: 0, y: topTextPadding)

            Spacer()
                        
            inputSection(priceBinding: priceBinding)
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing:
            Button(action: {
                self.showEditView.toggle()
            }) {
                Image(systemName: "gear")
                    .imageScale(.large)
                    .foregroundColor(Design.Color.Text.standard)
            }
        )
        .sheet(isPresented: $showEditView) {
            EditView().environmentObject(self.user)
        }
        .withBackground()
        .keyboardSensible($offsetValue, type: .paddingAndOffset, onAppearKeyboardCustom: {
            self.topTextPadding = -UIScreen.main.bounds.height/12
            self.isKeyboardVisible = true
        }, onHideKeyboardCustom: {
            self.topTextPadding = 0
            self.isKeyboardVisible = false
        })
        .onAppear() {
            if self.user.isOnboardingCompleted == false {
                self.user.isOnboardingCompleted = true
            }
        }
    }
    
    private func headerTextSection(timeMessage: String, formattedValue: String, priceAsSeconds: TimeInterval) -> some View {
        Group {
            Text("It will take")
                .multilineTextAlignment(.center)
                .font(Design.Font.standardLight)
                .foregroundColor(Design.Color.Text.standard)
                .animation(.none)
            Text("\(timeMessage)")
                .font(Design.Font.Title.smallTitleFont)
                .foregroundColor(Design.Color.Text.standard)
                .multilineTextAlignment(.center)
                .animation(.none)
                .padding(.top, 10)
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
        let priceNormalizedToWorkTime = TimeTextTranslator.normalizeTimeToWorkTime(priceAsSeconds: priceAsSeconds, dailyWorkHours: user.dailyWorkHours, weeklyWorkDays: user.workdays.count)
        guard let routine = TimeTextTranslator.getWorkRoutineDescriptionToPay(for: priceNormalizedToWorkTime, dailyWorkHours: user.dailyWorkHours, weeklyWorkDays: user.workdays.count) else {
            return Text("")
        }
        
        let seconds = routine.value * 1.hour
        guard let routineHoursAndMinutes = Formatter.hoursAndMinutes(seconds: seconds) else {
            return Text("")
        }
        
        switch routine.period {
        case .weekly:
            return Text("Working "+"\(routineHoursAndMinutes)"+" per week")
        case .daily:
            return Text("Working "+"\(routineHoursAndMinutes)"+" per day")
        }
    }
    
    private func tableImageSection(flow: Flow) -> some View {
        
        return Image("table\(flow.getExpensivityIndex(price: priceAsDouble, maxIndex: 13))")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: UIScreen.main.bounds.width-120, alignment: .center)
            .frame(minHeight: 150, alignment: .center)
            .animation(.none)
    }
    
    private func inputSection(priceBinding: Binding<Decimal>) -> some View {
        Group {
            Text("Type below the price")
                .font(Design.Font.smallLight)
                .foregroundColor(Design.Color.Text.standard)
                .isHidden(isKeyboardVisible)

            CurrencyField(priceBinding, placeholder: "Income".localized, textColor: .white)
                .frame(width: UIScreen.main.bounds.width-16, height: 50, alignment: .center)
                .background(Color(.sRGB, red: 94/255.0, green: 128/255.0, blue: 142/255.0, opacity: 1))
                .cornerRadius(100)
        }
        .offset(x: 0, y: (isKeyboardVisible) ? -8 : 0)
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

