//
//  CalculatorButton.swift
//  Widget
//
//  Created by Victor Melo on 20/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import UIKit

final class CalculatorButton: UIButton {
    
    let action: CalculatorAction
    
    init(title: String, action: CalculatorAction) {
        self.action = action
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
