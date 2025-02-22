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
    
    func absoluteX(base: UInt16) -> Int {
        Int(UInt16(truncatingIfNeeded: Int(base) + Int(registers.x)))
    }
    
    func absoluteY(base: UInt16) -> Int {
        Int(UInt16(truncatingIfNeeded: Int(base) + Int(registers.y)))
    }
    
    func indexedIndirect(base: UInt8) -> Int {
        let mem1 = Int(UInt8(truncatingIfNeeded: Int(base) + Int(registers.x)))
        let addrH = memory[Int(UInt8(truncatingIfNeeded: mem1 + 1))]
        return Int(memory[Int(mem1)]) | (Int(addrH) << 8)
    }
    
    func indirectIndexed(base: UInt8) -> Int {
        Int(memory[Int(base)]) | (Int(memory[Int(base) + 1]) << 8) + Int(registers.y)
    }
    
    func relative(offset: UInt8) -> UInt16 {
        UInt16(Int(registers.pc) + Int(P6502.twosComplement(value: offset)))
    }
}
