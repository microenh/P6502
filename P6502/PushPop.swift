//
//  PushPop.swift
//  P6502
//
//  Created by Mark Erbaugh on 2/22/25.
//

import Foundation

extension Model6502 {
    mutating func push(value: UInt8) {
        memory[Int(registers.sp)] = value
        registers.sp = UInt8(truncatingIfNeeded: Int(registers.sp) + 1)
    }
}
