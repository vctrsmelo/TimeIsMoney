//
//  CurrencyField.swift
//  Time is Money
//
//  Created by Victor Melo on 07/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import UIKit
import SwiftUI
import TimeIsMoneyCore

struct CurrencyField: UIViewRepresentable {
    
    private var placeholder: String?
    
    init(placeholder: String) {
        self.placeholder = placeholder
    }
    
    func makeUIView(context: Context) -> UICurrencyField {
        let v = UICurrencyField()
        v.placeholder = self.placeholder
        return v
    }
    
    func updateUIView(_ uiView: UICurrencyField, context: Context) {
        print("updated")
    }
}

final class UICurrencyField: UITextField {
    
    var decimal: Decimal { string.decimal / pow(10, Formatter.currency.maximumFractionDigits) }
    var maximum: Decimal = 999_999_999.99
    private var lastValue: String?
    var locale: Locale = .current {
        didSet {
            Formatter.currency.locale = locale
            sendActions(for: .editingChanged)
        }
    }
        
    override func willMove(toSuperview newSuperview: UIView?) {
        Formatter.currency.locale = locale
        self.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        keyboardType = .numberPad
        textAlignment = .right
        sendActions(for: .editingChanged)
    }
    
    override func deleteBackward() {
        text = string.digits.dropLast().string
        // manually send the editingChanged event
        sendActions(for: .editingChanged)
    }
    
    @objc
    private func editingChanged(_ textField: UITextField) {
        guard decimal <= maximum else {
            text = lastValue
            return
        }
        text = decimal.currency
        lastValue = text
        print("doubleValue:", doubleValue)
    }
    
}

extension UICurrencyField {
    var doubleValue: Double { (decimal as NSDecimalNumber).doubleValue }
}

extension UITextField {
     var string: String { text ?? "" }
}

extension NumberFormatter {
    convenience init(numberStyle: Style) {
        self.init()
        self.numberStyle = numberStyle
    }
}

extension StringProtocol where Self: RangeReplaceableCollection {
    var digits: Self { filter { $0.isWholeNumber } }
}

extension String {
    var decimal: Decimal { Decimal(string: digits) ?? 0 }
}

extension Decimal {
    var currency: String { Formatter.currency.string(for: self) ?? "" }
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}

struct CurrencyField_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            Text("O UIKit não atualiza no preview. Precisa executar no simulador.")
        }
    }

}

//struct CurrencyField: View {
//
//    private let adapter = MoneyInputAdapter()
//    @Binding var value: Decimal?
//
//    var body: some View {
//
//         let b = Binding<String>(
//            get: { return Formatters.currencyFormatter.string(from: self.value?.asNSNumber() ?? 0.0) ?? ""},
//               set: { newValue in
//                   self.value = Formatters.currencyFormatter.number(from: newValue)?.decimalValue
//           })
//
//        return TextField("Income", text: b)
//    }
//}
//
//struct CurrencyField_Previews: PreviewProvider {
//    static var previews: some View {
//        IncomeTest()
//    }
//
//    struct IncomeTest: View {
//
//        @State var value: Decimal?
//
//        var body: some View {
//            CurrencyField(value: $value)
//        }
//    }
//}
