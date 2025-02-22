//
//  Compare.swift
//  P6502
//
//  Created by Mark Erbaugh on 2/22/25.
//

import Foundation

extension Model6502 {
    mutating func compare(reg: UInt8, mem: UInt8) {
        let res = Int(reg) - Int(mem)
        registers.c = res >= 0
        registers.z = res == 0
        registers.n = res < 0
    }
    
    mutating func cmp(mem: UInt8) {
        compare(reg: registers.a, mem: mem)
    }
    
    mutating func cpx(mem: UInt8) {
        compare(reg: registers.x, mem: mem)
    }
    
    mutating func cpy(mem: UInt8) {
        compare(reg: registers.y, mem: mem)
    }
}
