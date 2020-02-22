//
//  TodayViewModel.swift
//  Widget
//
//  Created by Victor Melo on 21/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation
import SwiftUI

protocol TodayViewModelDelegate: AnyObject {
    func didUpdateWorkingTime(_ workingTime: String)
}

class TodayViewModel {


    weak var delegate: TodayViewModelDelegate?

    init(delegate: TodayViewModelDelegate? = nil) {
        self.delegate = delegate
    }

    func updateWorkingTime(newValue: NSDecimalNumber) {
//        guard case .success(let worktime) = Calculator.getWorkTimeToPay(for: newValue.doubleValue, user: user) else { return }
//        delegate?.didUpdateWorkingTime("\(worktime)")
    }
}
