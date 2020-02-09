//
//  Avatar.swift
//  Time is Money
//
//  Created by Victor Melo on 09/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

protocol Avatar {
    var scenarioString: String { get }
    var happy: Image { get }
    var normal: Image { get }
    var sad: Image { get }
}

struct AvatarMale1: Avatar {
    var scenarioString: String = "male1"
    var happy: Image = Image("male_1_happy")
    var normal: Image = Image("male_1_happy")
    var sad: Image = Image("male_1_happy")
}

struct AvatarMale2: Avatar {
    var scenarioString: String = "male2"
    var happy: Image = Image("male_2_happy")
    var normal: Image = Image("male_2_happy")
    var sad: Image = Image("male_2_happy")
}

struct AvatarFemale1: Avatar {
    var scenarioString: String = "female1"
    var happy: Image = Image("female_1_happy")
    var normal: Image = Image("female_1_happy")
    var sad: Image = Image("female_1_happy")
}

struct AvatarFemale2: Avatar {
    var scenarioString: String = "female2"
    var happy: Image = Image("female_2_happy")
    var normal: Image = Image("female_2_happy")
    var sad: Image = Image("female_2_happy")
}
