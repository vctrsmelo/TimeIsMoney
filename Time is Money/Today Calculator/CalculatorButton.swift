//
//  CalculatorButton.swift
//  Widget
//
//  Created by Victor Melo on 20/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import UIKit

final class CalculatorButton: UIButton {
    
    let action: CalculatorButtonAction
    
    init(title: String, action: CalculatorButtonAction) {
        self.action = action
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@objc
protocol CalculatorButtonAction {
    @objc func action(_ input: NSDecimalNumber) -> NSDecimalNumber
}

@objc
class ClearAction: NSObject, CalculatorButtonAction {
    func action(_ input: NSDecimalNumber) -> NSDecimalNumber {
        NSDecimalNumber(value: 0)
    }
}

class AddValueAction: CalculatorButtonAction {
    
    private var value = NSDecimalNumber(value: 0)
    
    init(value: NSDecimalNumber) {
        self.value = value
    }
    
    static func withValue(_ value: NSDecimalNumber) -> AddValueAction {
        AddValueAction(value: value)
    }
    
    func action(_ input: NSDecimalNumber) -> NSDecimalNumber {
        input.adding(value)
    }
}
