//
//  PushPop.swift
//  P6502
//
//  Created by Mark Erbaugh on 2/22/25.
//

import Foundation

extension Model6502 {
    mutating func push(value: UInt8) {
        memory[0x0100 + Int(registers.sp)] = value
        registers.sp = UInt8(truncatingIfNeeded: Int(registers.sp) + 1)
    }
    
    mutating func pop() -> UInt8 {
        registers.sp = UInt8(truncatingIfNeeded: Int(registers.sp) - 1)
        return memory[0x0100 + Int(registers.sp)]
    }
}
