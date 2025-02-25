//
//  Utility.swift
//  P6502
//
//  Created by Mark Erbaugh on 2/22/25.
//

import Foundation

func twosComplement(value: UInt8) -> Int8 {
    value <= 0x80 ? Int8(truncatingIfNeeded: value) :
    -Int8(truncatingIfNeeded: (~value + 1))
}

func zeroNegativeFlags(value: UInt8) -> (zero: Bool, negative: Bool) {
    (zero: value == 0x00, negative: value >= 0x80)
}

func toHex(_ value: Int) -> String {
    "0x\(String(value, radix: 16))"
}
