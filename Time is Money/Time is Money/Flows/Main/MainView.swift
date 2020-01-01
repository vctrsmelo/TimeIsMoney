//
//  ContentView.swift
//  Time is Money
//
//  Created by Victor S Melo on 10/10/19.
//  Copyright © 2019 Victor S Melo. All rights reserved.
//

import SwiftUI
import TimeIsMoneyCore

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

struct MainView: View {
    
    @State private var price: Double = 6600.00
    
    private let flow = Flow(monthlySalary: 6600, weeklyWorkHours: 44, weeklyWorkDays: 5)
    
    private var currencyFormatter: NumberFormatter = {
        let f = NumberFormatter()
        // allow no currency symbol, extra digits, etc
        f.isLenient = true
        f.numberStyle = .currency
        return f
    }()
    
    var body: some View {
        
        let formattedValue = currencyFormatter.string(from: NSNumber(value: price)) ?? "?"
        let maybeTimeNeeded = flow.getTimeNeededToPay(for: price)
        
        let timeMessage: String
        let quickAnswers: [Double] = [100, 200, 500, 1000]
        
        switch maybeTimeNeeded {
        case .success(let worktime):
            let dailyWorkHours = floor(flow.user.weeklyWorkHours / Double(flow.user.weeklyWorkDays))
            timeMessage = TimeTextTranslator.getUserWorkTimeDescription(from: worktime, dailyWorkHours: dailyWorkHours, weeklyWorkDays:  flow.user.weeklyWorkDays)
        case .failure(let error):
            timeMessage = "¯\\_(ツ)_/¯"
            print(error)
        }
        
        return VStack {
            
            //header
            Text("You have to work \(timeMessage)")
                .padding(.top, 120)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
            Text("To pay those \(formattedValue)")
                .multilineTextAlignment(.center)
            // image
            Image("table\(flow.getExpensivityIndex(price: price, maxIndex: 13))")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(EdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16))
            // input
            Spacer()
            
            ScrollView (.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(quickAnswers, id: \.self) { quickAnswer in
                        QuickAnswerView(value: quickAnswer).onTapGesture {
                            self.price = quickAnswer
                        }
                    }
                }
            }
            
            TextField("", value: $price, formatter: NumberFormatter())
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .frame(width: nil, height: 100, alignment: .center)
                .background(Color(.sRGB, red: 94/255.0, green: 128/255.0, blue: 142/255.0, opacity: 1))
        }
        .background(Design.backgroundColor)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
