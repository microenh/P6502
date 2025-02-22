//
//  BRK.swift
//  P6502
//
//  Created by Mark Erbaugh on 2/22/25.
//

import Foundation

extension Model6502 {
    mutating func brk() {
        push(value: UInt8(truncatingIfNeeded: registers.pc))
        push(value: UInt8(truncatingIfNeeded: registers.pc >> 8))
        push(value: registers.flags)
        registers.b = true
        registers.pc = UInt16(truncatingIfNeeded: Int(memory[0xfffe])
                                + Int(memory[0xffff]) << 8)
    }
}
