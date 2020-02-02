//
//  Device.swift
//  Time is Money
//
//  Created by Victor Melo on 02/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import UIKit

enum Device {
    static var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
}
