//
//  ContentView.swift
//  Time is Money
//
//  Created by Victor S Melo on 10/10/19.
//  Copyright © 2019 Victor S Melo. All rights reserved.
//

import SwiftUI
import TimeIsMoneyCore

struct MainView: View {
    
    @EnvironmentObject var user: User
    
    @State private var price: Decimal = 6600.00
    @State private var offsetValue: CGFloat = 0.0
    @State private var showEditView = false
    
    private var priceAsDouble: Double {
        return (price as NSDecimalNumber?)?.doubleValue ?? 0.0
    }
    
    private let flow = Flow()
    
    private var currencyFormatter: NumberFormatter = {
        let f = NumberFormatter()
        // allow no currency symbol, extra digits, etc
        f.isLenient = true
        f.numberStyle = .currency
        return f
    }()
    
    var body: some View {
        
        let formattedValue = currencyFormatter.string(from: NSNumber(value: priceAsDouble)) ?? "?"
        let maybeTimeNeeded = flow.getTimeNeededToPay(for: priceAsDouble)
        
        let timeMessage: String
        let quickAnswers: [Double] = [100, 200, 500, 1000]
        
        switch maybeTimeNeeded {
        case .success(let worktime):
            let dailyWorkHours = floor(Double(flow.user.weeklyWorkHours)/Double(flow.user.workdays.count))
            timeMessage = TimeTextTranslator.getUserWorkTimeDescription(from: worktime, dailyWorkHours: dailyWorkHours, weeklyWorkDays:  flow.user.workdays.count)
        case .failure(let error):
            timeMessage = "¯\\_(ツ)_/¯"
            print(error)
        }

        return VStack {
            
            //header
            Text("You have to work")
                .multilineTextAlignment(.center)
                .font(Design.Font.standardLight)
                .foregroundColor(Design.Color.Text.standard)
                .padding(.bottom, 10)
                .padding(.top, 10)
                .animation(.none)
            Text("\(timeMessage)")
                .font(Design.Font.Title.smallTitleFont)
                .foregroundColor(Design.Color.Text.standard)
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
                .animation(.none)
            Text("To pay those")
                .multilineTextAlignment(.center)
                .font(Design.Font.standardLight)
                .foregroundColor(Design.Color.Text.standard)
                .padding(.bottom, 10)
                .animation(.none)
            Text("\(formattedValue)")
                .font(Design.Font.subtitle)
                .foregroundColor(Design.Color.Text.standard)
                .padding(.bottom, 10)
                .animation(.none)
            // image
            Image("table\(flow.getExpensivityIndex(price: priceAsDouble, maxIndex: 13))")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: UIScreen.main.bounds.width/2, maxWidth: UIScreen.main.bounds.width-64, minHeight: 64, maxHeight: 160, alignment: .center)
                .padding(EdgeInsets(top: 20, leading: 16, bottom: 8, trailing: 16))
                .animation(.none)
            // input
            Spacer()
            
            ScrollView (.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(quickAnswers, id: \.self) { quickAnswer in
                        QuickAnswerView(value: quickAnswer).onTapGesture {
                            self.price = Decimal(quickAnswer)
                        }
                    }
                }
            }

            CurrencyField($price, placeholder: "Income", textColor: .white)
                .frame(width: UIScreen.main.bounds.width, height: 120, alignment: .center)
                .background(Color(.sRGB, red: 94/255.0, green: 128/255.0, blue: 142/255.0, opacity: 1))
        }
        .navigationBarItems(trailing:
            Button(action: {
                self.showEditView.toggle()
            }) {
                Image(systemName: "person.crop.circle").imageScale(.large)
            }
        )
        .sheet(isPresented: $showEditView) {
            EditView().environmentObject(self.user)
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true)
            
        .withBackground()
        .keyboardSensible($offsetValue, type: .paddingAndOffset, onAppearKeyboardCustom: nil, onHideKeyboardCustom: nil)
        .animation(.spring())
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

// MARK: - Other Views

struct QuickAnswerView: View {
    
    private var value: Double = 0.0
    
    private var currencyFormatter: NumberFormatter = {
        let f = NumberFormatter()
        // allow no currency symbol, extra digits, etc
        f.isLenient = true
        f.numberStyle = .currency
        return f
    }()
    
    init(value: Double) {
        self.value = value
    }
    
    var body: some View {
        let formattedValue = currencyFormatter.string(from: NSNumber(value: value)) ?? "?"
        
        return Text(" \(formattedValue) ")
            .foregroundColor(.white)
            .background(Color(.sRGB, red: 94/255.0, green: 128/255.0, blue: 142/255.0, opacity: 1)
            )
            .cornerRadius(5)
 
    }
}
