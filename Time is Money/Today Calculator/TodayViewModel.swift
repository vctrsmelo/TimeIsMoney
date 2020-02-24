//
//  TodayViewModel.swift
//  Widget
//
//  Created by Victor Melo on 21/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation


protocol TodayViewModelDelegate: AnyObject {
    func didUpdateWorkingTime(_ workingTime: String)
}

class TodayViewModel {
    
    let monthlySalary: NSDecimalNumber
    let weeklyWorkHours: Int
    let weeklyWorkdays: [WidgetWeekday]

    weak var delegate: TodayViewModelDelegate?

    init(delegate: TodayViewModelDelegate? = nil) {
        self.delegate = delegate
        
        let db = UserDefaultsRepository()
        self.monthlySalary = NSDecimalNumber(value: db.loadMonthlySalary())
        self.weeklyWorkHours = db.loadWeeklyWorkHours()
        self.weeklyWorkdays = db.loadWorkdays()
        
    }

    func updateWorkingTime(newValue: NSDecimalNumber) {
//        guard case .success(let worktime) = Calculator.getWorkTimeToPay(for: newValue.doubleValue, user: user) else { return }
//        delegate?.didUpdateWorkingTime("\(worktime)")
    }
}
