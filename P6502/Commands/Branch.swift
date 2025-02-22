//
//  Branch.swift
//  P6502
//
//  Created by Mark Erbaugh on 2/21/25.
//

import Foundation

extension Model6502 {
    mutating func branch(flag: Bool, offset: UInt8) {
        registers.pc = UInt16(relative(offset: (flag ? offset : 0)))
    }
    
    mutating func bcc(offset: UInt8) {
        branch(flag: !registers.c, offset: offset)
    }
    
    mutating func bcs(offset: UInt8) {
        branch(flag: registers.c, offset: offset)
    }
    
    mutating func beq(offset: UInt8) {
        branch(flag: registers.z, offset: offset)
    }
    
    mutating func bne(offset: UInt8) {
        branch(flag: !registers.z, offset: offset)
    }
    
    mutating func bmi(offset: UInt8) {
        branch(flag: registers.n, offset: offset)
    }
    
    mutating func bpl(offset: UInt8) {
        branch(flag: !registers.n, offset: offset)
    }
    
    mutating func bvs(offset: UInt8) {
        branch(flag: registers.o, offset: offset)
    }
    
    mutating func bvc(offset: UInt8) {
        branch(flag: !registers.o, offset: offset)
    }
}
