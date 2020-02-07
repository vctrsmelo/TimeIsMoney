//
//  CurrencyField.swift
//  Time is Money
//
//  Created by Victor Melo on 07/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import UIKit
import SwiftUI

struct CurrencyField: UIViewRepresentable {
    
    private var value: Binding<Decimal>
    private var placeholder: String?
    private var textColor: UIColor
    private var font: UIFont
    private var textAlignment: NSTextAlignment
    
    var keyboardWillHide: (() -> ())?
    var keyboardWillShow: (() -> ())?
    
    init(_ value: Binding<Decimal>, placeholder: String, textColor: UIColor = Design.UIColor.Text.title, font: UIFont = Design.UIFont.Title.smallTitleFont, textAlignment: NSTextAlignment = .center, keyboardWillHide: (() -> ())? = nil, keyboardWillShow: (() -> ())? = nil) {
        self.value = value
        self.placeholder = placeholder
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
        self.keyboardWillHide = keyboardWillHide
        self.keyboardWillShow = keyboardWillShow
    }
    
    func makeUIView(context: Context) -> UICurrencyField {
        let v = UICurrencyField(value)
        v.placeholder = self.placeholder
        v.textColor = textColor
        v.font = font
        v.textAlignment = self.textAlignment
        v.keyboardWillHideClosure = self.keyboardWillHide
        v.keyboardWillShowClosure = self.keyboardWillShow
        return v
    }
    
    func updateUIView(_ uiView: UICurrencyField, context: Context) {
        uiView.text = value.wrappedValue.currency
    }
}

final class UICurrencyField: UITextField {
    
    var decimal: Decimal { string.decimal / pow(10, Formatter.currency.maximumFractionDigits) }
    var maximum: Decimal = 8_000_000
    var lastValue: String?
    
    private var value: Binding<Decimal>?
    
    var keyboardWillHideClosure: (() -> ())?
    var keyboardWillShowClosure: (() -> ())?
    
    var locale: Locale = .current {
        didSet {
            Formatter.currency.locale = locale
            sendActions(for: .editingChanged)
        }
    }
    
    init(_ value: Binding<Decimal>) {
        super.init(frame: .zero)
        self.value = value
        self.text = value.wrappedValue.currency
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        Formatter.currency.locale = locale
        self.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        keyboardType = .numberPad
        sendActions(for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyBoardWillShow(notification: Notification) {
        keyboardWillShowClosure?()
    }

    @objc func keyBoardWillHide(notification: Notification) {
        keyboardWillHideClosure?()
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
        value?.wrappedValue = decimal
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
