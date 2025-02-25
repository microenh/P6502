//
//  Addressing.swift
//  P6502
//
//  Created by Mark Erbaugh on 2/21/25.
//

import Foundation

extension Model6502 {
    func zeroPage(base: UInt8) -> Int {
        Int(base)
    }
    
    func zeroPageX(base: UInt8) -> Int {
        Int(UInt8(truncatingIfNeeded: Int(base) + Int(registers.x)))
    }
    
    func zeroPageY(base: UInt8) -> Int {
        Int(UInt8(truncatingIfNeeded: Int(base) + Int(registers.y)))
    }
    
    func absolute(base: UInt16) -> Int {
        Int(base)
    }
    
    // note: no extra cycles ASL
    mutating func absoluteX(base: UInt16) -> Int {
        let newAddr = Int(UInt16(truncatingIfNeeded: Int(base) + Int(registers.x)))
        extraCycles = (newAddr & 0xff00) == (Int(base) & 0xff00) ? 0 : 1
        return newAddr
    }
    
    mutating func absoluteY(base: UInt16) -> Int {
        let newAddr = Int(UInt16(truncatingIfNeeded: Int(base) + Int(registers.y)))
        extraCycles = (newAddr & 0xff00) == (Int(base) & 0xff00) ? 0 : 1
        return newAddr
    }
    
    func indexedIndirect(base: UInt8) -> Int {
        let mem1 = Int(UInt8(truncatingIfNeeded: Int(base) + Int(registers.x)))
        let addrH = memory[Int(UInt8(truncatingIfNeeded: mem1 + 1))]
        return Int(memory[Int(mem1)]) | (Int(addrH) << 8)
    }
    
    // note: no extra cycles for STA
    mutating func indirectIndexed(base: UInt8) -> Int {
        let newAddr = Int(memory[Int(base)])
            | (Int(memory[Int(UInt8(truncatingIfNeeded: Int(base) + 1))]) << 8)
        let ofsAddr = newAddr + Int(registers.y)
        extraCycles = (newAddr & 0xff00) == (ofsAddr & 0xff00) ? 0 : 1
        return ofsAddr
    }
    
    mutating func relative(offset: UInt8) -> UInt16 {
        if offset != 0 {
            let new_addr = UInt16(Int(registers.pc) + Int(P6502.twosComplement(value: offset)))
            extraCycles = (registers.pc & 0xff00) == (new_addr & 0xff00) ? 1 : 2
            return new_addr
        } else {
            extraCycles = 0
            return registers.pc
        }
    }
}
