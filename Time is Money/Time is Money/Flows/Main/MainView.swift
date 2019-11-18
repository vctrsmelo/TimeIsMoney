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
    
    @State private var price: Double = 6600.00
    
    private let flow = Flow(monthlySalary: 6600, weeklyWorkHours: 40, weeklyWorkDays: 5)
    
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
        
        switch maybeTimeNeeded {
        case .success(let worktime):
            let dailyWorkHours = floor(flow.user.weeklyWorkHours / Double(flow.user.weeklyWorkDays))
            timeMessage = TimeTextTranslator.getDescription(from: worktime, dailyWorkHours: dailyWorkHours, weeklyWorkDays:  flow.user.weeklyWorkDays)
        case .failure(let error):
            timeMessage = "¯\\_(ツ)_/¯"
            print(error)
        }
        
        return VStack {
            
            //header
            Text("Você terá que trabalhar \(timeMessage)")
                .padding(.top, 120)
            Text("")
            Text("para pagar estes \(formattedValue)")
            // image
            Image("table\(flow.getExpensivityIndex(price: price, maxIndex: 13))")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(EdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16))
            // input
            Spacer()
            TextField("Price", value: $price, formatter: currencyFormatter)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .frame(width: nil, height: 100, alignment: .center)
                .background(Color(.sRGB, red: 94/255.0, green: 128/255.0, blue: 142/255.0, opacity: 1))
        }
        .background(Color(.sRGB, red: 255/255.0, green: 254/255.0, blue: 240/255.0, opacity: 1))
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
