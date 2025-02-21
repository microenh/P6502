//
//  BIT.swift
//  P6502
//
//  Created by Mark Erbaugh on 2/21/25.
//

import Foundation

extension Model6502 {
    mutating func bit(value: UInt8) {
        let r = a & value
        z = r == 0
        o = r & 0x40 > 0
        n = r & 0x80 > 0
    }
}
