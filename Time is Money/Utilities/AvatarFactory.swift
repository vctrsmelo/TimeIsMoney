//
//  AvatarFactory.swift
//  Time is Money
//
//  Created by Victor Melo on 08/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

struct AvatarFactory {
    
    static func male1() -> Avatar {
        Avatar(happy: Image("male_1_happy"), normal: Image("male_1_normal"), sad: Image("male_1_sad"))
    }
    
    static func male2() -> Avatar {
        Avatar(happy: Image("male_2_happy"), normal: Image("male_2_normal"), sad: Image("male_2_sad"))
    }
    
    static func female1() -> Avatar {
        Avatar(happy: Image("female_1_happy"), normal: Image("female_1_normal"), sad: Image("female_1_sad"))
    }
    
    static func female2() -> Avatar {
        Avatar(happy: Image("female_2_happy"), normal: Image("female_2_normal"), sad: Image("female_2_sad"))
    }
}
