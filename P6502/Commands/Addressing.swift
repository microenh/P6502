//
//  Addressing.swift
//  P6502
//
//  Created by Mark Erbaugh on 2/21/25.
//

import Foundation

enum RegisterAddressMode {
    case zeroPage
    case zeroPageX
    case zeroPageY
    case absolute
    case absoluteX
    case absoluteY
    case indexedIndirect
    case indirectIndexed
    case relative
}

extension Model6502 {
    func address(mode: RegisterAddressMode, base: UInt16) -> Int {
        switch mode {
        case .zeroPage:
            return Int(base)
        case .zeroPageX:
            return Int(UInt8(truncatingIfNeeded: Int(base) + Int(x)))
        case .zeroPageY:
            return Int(UInt8(truncatingIfNeeded: Int(base) + Int(y)))
        case .absolute:
            return Int(base)
        case .absoluteX:
            return Int(UInt16(truncatingIfNeeded: Int(base) + Int(x)))
        case .absoluteY:
            return Int(UInt16(truncatingIfNeeded: Int(base) + Int(y)))
        case .indexedIndirect:
            let mem1 = Int(UInt8(truncatingIfNeeded: Int(base) + Int(x)))
            let addrH = memory[Int(UInt8(truncatingIfNeeded: mem1 + 1))]
            return Int(memory[Int(mem1)]) | (Int(addrH) << 8)
        case .indirectIndexed:
            return Int(memory[Int(base)]) | (Int(memory[Int(base) + 1]) << 8) + Int(y)
        case .relative:
            return Int(pc) + Int(Model6502.twosComplement(value: UInt8(truncatingIfNeeded: base)))
        }
    }    
}
