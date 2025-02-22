//
//  BIT.swift
//  P6502
//
//  Created by Mark Erbaugh on 2/21/25.
//

import Foundation

extension Model6502 {
    mutating func bit(value: UInt8) {
        let r = registers.a & value
        registers.z = r == 0
        registers.o = r & 0x40 > 0
        registers.n = r & 0x80 > 0
    }
}
