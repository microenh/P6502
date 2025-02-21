//
//  Model6502-SBC.swift
//  P6502
//
//  Created by Mark Erbaugh on 2/21/25.
//

import Foundation

extension Model6502 {
    mutating func sbc(sub: UInt8) {
        var done = false
        var res = 0
        if d {
            let rng = 0...9
            let a1 = Int(a & 0x0f),
                a10 = Int(a & 0xf0) >> 4,
                ad1 = Int(sub & 0x0f),
                ad10 = Int(sub & 0xf0) >> 4
            if rng.contains(a1) && rng.contains(a10)
                && rng.contains(ad1) && rng.contains(ad10) {
                res = a1 - ad1 + 10 * (a10 - ad10) - (c ? 0 : 1)
                c = res > 0
                if !c {
                    res += 100
                }
                res = ((res / 10) << 4) | (res % 10)
                done = true
            }
        }
        if !done {
            res = Int(a) + (Int(~sub)) + (c ? 1 : 0)
            c = Int(a) >= Int(sub)
        }
        o = (Int(a) ^ res) & (Int(~sub) ^ res) & 0x80 > 0
        a = UInt8(truncatingIfNeeded: res)
    }
}
