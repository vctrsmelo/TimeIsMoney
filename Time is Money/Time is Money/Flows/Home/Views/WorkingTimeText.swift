//
//  WorkingTimeBuilder.swift
//  Time is Money
//
//  Created by Victor Melo on 10/06/21.
//  Copyright © 2021 Victor S Melo. All rights reserved.
//

import Foundation
import SwiftUI

struct WorkingTimeText: View {
    
    @Binding var priceAsSeconds: TimeInterval
    @Binding var user: User
    
    var body: some View {
        getExpectedWorkingTimeText(priceAsSeconds: priceAsSeconds)
    }
    
    private func getExpectedWorkingTimeText(priceAsSeconds: TimeInterval) -> Text {
        let priceNormalizedToWorkTime = TimeTextTranslator.getNormalizedWorkTimeFrom(priceAsSeconds: NSDecimalNumber(value: priceAsSeconds), user: user)
        guard let routine = TimeTextTranslator.getWorkRoutineDescriptionToPay(for: priceNormalizedToWorkTime, dailyWorkHours: user.dailyWorkHours, weeklyWorkDays: user.workdays.count) else {
            return Text("")
        }
        
        let seconds = routine.value * NSDecimalNumber(value: 1.hourInSeconds)
        guard let routineHoursAndMinutes = Formatter.hoursAndMinutes(seconds: seconds.doubleValue) else {
            return Text("")
        }
        
        switch routine.period {
        case .weekly:
            return Text(R.string.localizable.working()+" \(routineHoursAndMinutes) "+R.string.localizable.perWeek())
        case .daily:
            return Text(R.string.localizable.working()+" \(routineHoursAndMinutes) "+R.string.localizable.perDay())
        }
    }
}
