//
//  JmpJsr.swift
//  P6502
//
//  Created by Mark Erbaugh on 2/22/25.
//

import Foundation

extension Model6502 {
    mutating func jmpAbsolute(addr: UInt16) {
        registers.pc = addr
    }
    
    mutating func jmpIndirect(addr: UInt16) {
        if addr & 0xff == 0xff {
            // bug in original 6502
            registers.pc = UInt16(truncatingIfNeeded: Int(memory[Int(addr)])
                                  | (Int(memory[Int(addr & 0xff00)]) << 8))
        } else {
            // normal behavior
            registers.pc = UInt16(truncatingIfNeeded: Int(memory[Int(addr)])
                                  | (Int(memory[Int(addr) + 1]) << 8))
        }
    }
    
    mutating func jsr(addr: UInt16) {
        let oldPC = UInt16(truncatingIfNeeded: registers.pc + 1)
        push(value: UInt8(oldPC & 0xff))
        push(value: UInt8((oldPC & 0xff00) >> 8))
        registers.pc = addr
    }
    
    mutating func rts() {
        registers.pc = UInt16(truncatingIfNeeded: (Int(pop()) << 8) + Int(pop()) + 1)
    }
    
    mutating func rti() {
        registers.flags = pop()
        registers.pc = UInt16(truncatingIfNeeded: (Int(pop()) << 8) | Int(pop()))
    }
}
