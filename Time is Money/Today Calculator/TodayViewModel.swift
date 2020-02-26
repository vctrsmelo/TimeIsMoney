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
    
    let user: User

    weak var delegate: TodayViewModelDelegate?

    init(delegate: TodayViewModelDelegate? = nil) {
        self.delegate = delegate
        
        let db = UserDefaultsRepository()
        user = db.loadUser()
    }

    func updateWorkingTime(for monetaryValue: NSDecimalNumber) {
        
        guard case .success(let worktime) = Calculator.getWorkTimeToPay(for: monetaryValue.doubleValue, user: user) else { return }
        
        let formattedWorktime = TimeTextTranslator.getWorkTimeDescriptionToPay(for: worktime, user: user)
        delegate?.didUpdateWorkingTime(formattedWorktime)
    }
}
