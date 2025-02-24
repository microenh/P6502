//
//  Shift.swift
//  P6502
//
//  Created by Mark Erbaugh on 2/21/25.
//

import Foundation

extension Model6502 {
    mutating func asl(value: UInt8) -> UInt8 {
        let r = value << 1
        (registers.z, registers.n) = zeroNegativeFlags(value: r)
        registers.c = value >= 0x80
        return r
    }
    
    mutating func lsr(value: UInt8) -> UInt8 {
        registers.c = (value & 0x01) > 0
        let r = value >> 1
        (registers.z, registers.n) = zeroNegativeFlags(value: r)
        return r
    }
    
    mutating func rol(value: UInt8) -> UInt8 {
        let r = UInt8(truncatingIfNeeded: (value) << 1)
            | UInt8(registers.c ? 1 : 0)
        registers.c = (value & 0x80) > 0
        registers.z = (r == 0)
        registers.n = ((r & 0x80) > 0)
        return r
    }

    mutating func ror(value: UInt8) -> UInt8 {
        let r = (value >> 1) | (registers.c ? 0x80 : 0x00)
        registers.c = (value & 0x01) > 0
        registers.z = (r == 0)
        registers.n = ((r & 0x80) > 0)
        return r
    }
}
