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
    
    @Published public var monthlySalary: Double {
        didSet {
            UserDefaults.standard.set(monthlySalary, forKey: "MonthlySalary")
            print("didSet salary: \(monthlySalary)")
        }
    }
    
    @Published public var weeklyWorkHours: Int {
        didSet {
            UserDefaults.standard.set(weeklyWorkHours, forKey: "WeeklyWorkHours")
        }
    }
    
    @Published public var workdays: [Weekday] {
        didSet {
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
    
    public init() {
        self.monthlySalary = UserDefaults.standard.double(forKey: "MonthlySalary")
        self.weeklyWorkHours = UserDefaults.standard.integer(forKey: "WeeklyWorkHours")
        
        self.workdays = [Weekday]()
        if let workdaysData = UserDefaults.standard.data(forKey: "Workdays") {
            if let decoded = try? JSONDecoder().decode([Weekday].self, from: workdaysData) {
                self.workdays = decoded
            }
        }
    }
}
