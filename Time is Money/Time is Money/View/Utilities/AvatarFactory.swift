//
//  AvatarFactory.swift
//  Time is Money
//
//  Created by Victor Melo on 08/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

struct AvatarFactory {

    static let all: [Avatar] = {
        [male1(), male2(), female1(), female2()]
    }()

    static let allMale: [Avatar] = {
        [male1(), male2()]
    }()
    
    static let allFemale: [Avatar] = {
        [female1(), female2()]
    }()
    
    static func male1() -> Avatar {
        AvatarMale1()
    }
    
    static func male2() -> Avatar {
        AvatarMale2()
    }
    
    static func female1() -> Avatar {
        AvatarFemale1()
    }
    
    static func female2() -> Avatar {
        AvatarFemale2()
    }
    
    static func getById(id: String) -> Avatar {
        all.first { $0.id == id } ?? AvatarMale2()
    }
}
