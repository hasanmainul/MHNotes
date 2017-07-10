//
//  Date.swift
//  Notes
//
//  Created by mainul on 7/10/17.
//  Copyright © 2017 mainul. All rights reserved.
//

import Foundation

extension Date {
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }

    init(ticks: UInt64) {
        self.init(timeIntervalSince1970: Double(ticks)/10_000_000 - 62_135_596_800)
    }
}
