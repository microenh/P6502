//
//  IncDec.swift
//  P6502
//
//  Created by Mark Erbaugh on 2/22/25.
//

import Foundation

extension Model6502 {
    
    mutating func inc(value: UInt8) -> UInt8 {
        let r = UInt8(truncatingIfNeeded: Int(value) + 1)
        (registers.z, registers.n) = zeroNegativeFlags(value: r)
        return r
    }
    
    mutating func inx() {
        registers.x = UInt8(truncatingIfNeeded: Int(registers.x) + 1)
    }
    
    mutating func iny() {
        registers.y = UInt8(truncatingIfNeeded: Int(registers.y) + 1)
    }
    
    mutating func dec(value: UInt8) -> UInt8 {
        let r = UInt8(truncatingIfNeeded: Int(value) - 1)
        (registers.z, registers.n) = zeroNegativeFlags(value: r)
        return r
    }
    
    mutating func dex() {
        registers.x = UInt8(truncatingIfNeeded: Int(registers.x) - 1)
    }
    
    mutating func dey() {
        registers.y = UInt8(truncatingIfNeeded: Int(registers.y) - 1)
    }
    
    mutating func eor(value: UInt8) {
        registers.a ^= value
    }
}
