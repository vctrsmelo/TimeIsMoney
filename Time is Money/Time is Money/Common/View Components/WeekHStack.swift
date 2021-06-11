//
//  WeekHStack.swift
//  Time is Money
//
//  Created by Victor Melo on 17/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

struct WeekHStack: View {
    
    var body: some View {
        HStack {
            ForEach(Weekday.all(), id: \.self) {
                WeekdayView($0)
            }
        }
    }
}

struct WeekHStack_Previews: PreviewProvider {
    static var previews: some View {
        WeekHStack()
    }
}
