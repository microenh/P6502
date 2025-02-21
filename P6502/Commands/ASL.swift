//
//  ASL.swift
//  P6502
//
//  Created by Mark Erbaugh on 2/21/25.
//

import Foundation

extension Model6502 {
    mutating func asl(value: UInt8) -> UInt8 {
        let r = value << 1
        (z, n) = Model6502.zeroNegativeFlags(value: r)
        c = value >= 0x80
        return r
    }
}
