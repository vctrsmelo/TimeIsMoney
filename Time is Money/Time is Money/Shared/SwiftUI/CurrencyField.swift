//
//  CurrencyField.swift
//  Time is Money
//
//  Created by Victor Melo on 07/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI
import TimeIsMoneyCore

struct CurrencyField: View {
    
    private let adapter = MoneyInputAdapter()
    @Binding var value: Decimal?
    
    var body: some View {
        
         let b = Binding<String>(
            get: { return Formatters.currencyFormatter.string(from: self.value?.asNSNumber() ?? 0.0) ?? ""},
               set: { newValue in
                   self.value = Formatters.currencyFormatter.number(from: newValue)?.decimalValue
           })
        
        return TextField("Income", text: b)
    }
}

struct CurrencyField_Previews: PreviewProvider {
    static var previews: some View {
        IncomeTest()
    }
    
    struct IncomeTest: View {
        
        @State var value: Decimal?
        
        var body: some View {
            CurrencyField(value: $value)
        }
    }
}
