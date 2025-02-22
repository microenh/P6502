//
//  ADC.swift
//  P6502
//
//  Created by Mark Erbaugh on 2/21/25.
//

import Foundation

extension Model6502 {
    mutating func adc(add: UInt8) {
        var done = false
        var res = 0
        if registers.d {
            let rng = 0...9
            let a1 = Int(registers.a & 0x0f),
                a10 = Int(registers.a & 0xf0) >> 4,
                ad1 = Int(add & 0x0f),
                ad10 = Int(add & 0xf0) >> 4
            if rng.contains(a1) && rng.contains(a10)
                && rng.contains(ad1) && rng.contains(ad10) {
                res = a1 + ad1 + 10 * (a10 + ad10) + (registers.c ? 1 : 0)
                registers.c = res > 99
                res %= 100
                res = ((res / 10) << 4) | (res % 10)
                done = true
            }
        }
        if !done {
            res = Int(registers.a) + Int(add) + (registers.c ? 1 : 0)
            registers.c = res > 0xff
        }
        registers.o = (Int(registers.a) ^ res) & (Int(add) ^ res) & 0x80 > 0
        registers.a = UInt8(truncatingIfNeeded: res)
    }
}
