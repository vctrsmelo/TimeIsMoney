//
//  User.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 18/11/19.
//  Copyright © 2019 Victor Melo. All rights reserved.
//

import Foundation

public class User: ObservableObject {
    
    public static var instance = User()
    private var testing: Bool
    
    @Published public var monthlySalary: Decimal {
        didSet {
            guard testing == false else { return }
            UserDefaults.standard.set(monthlySalary, forKey: "MonthlySalary")
            print("didSet salary: \(monthlySalary)")
        }
    }
    
    @Published public var weeklyWorkHours: Int {
        didSet {
            guard testing == false else { return }
            syncWorkdaysWithWorkHours()
            UserDefaults.standard.set(weeklyWorkHours, forKey: "WeeklyWorkHours")
        }
    }
    
    @Published public var workdays: [Weekday] {
        didSet {
            guard testing == false else { return }
            syncWorkdaysWithWorkHours()
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(workdays) {
                UserDefaults.standard.set(encoded, forKey: "Workdays")
            }
        }
    }
    
    public var sortedWorkdays: [Weekday] {
        var sortedWorkdays = Weekday.all()
        sortedWorkdays.removeAll {
            !self.workdays.contains($0)
        }
        
        return sortedWorkdays
    }
    
    public init(testing: Bool = false) {
        self.testing = testing
        if testing {
            self.monthlySalary = 1000.0
            self.weeklyWorkHours = 7
            self.workdays = Weekday.all()
            
        } else {
            self.monthlySalary = UserDefaults.standard.double(forKey: "MonthlySalary").asDecimal()
            self.weeklyWorkHours = UserDefaults.standard.integer(forKey: "WeeklyWorkHours")
            
            self.workdays = [Weekday]()
            if let workdaysData = UserDefaults.standard.data(forKey: "Workdays") {
                if let decoded = try? JSONDecoder().decode([Weekday].self, from: workdaysData) {
                    self.workdays = decoded
                }
            }
        }

    }
    
    private func syncWorkdaysWithWorkHours() {
        if weeklyWorkHours < workdays.count {
            weeklyWorkHours = workdays.count
            print("Alert: User weekly hour adjusted")
        } else if weeklyWorkHours > workdays.count*24 {
            weeklyWorkHours = workdays.count*24
        }
    }
    
    public func isSelectedHoursValid(_ selectedHours: Int) -> Bool {
        return (selectedHours < workdays.count || selectedHours > workdays.count * 24)
    }
}
