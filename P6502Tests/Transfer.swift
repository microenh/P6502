//
//  Transfer.swift
//  P6502Tests
//
//  Created by Mark Erbaugh on 2/24/25.
//

import Testing
@testable import P6502

struct Transfer {
    var p = Model6502()
    
    @Test
    mutating func tax() {
        p.registers.a = 0x80
        p.tax()
        #expect(p.registers.x == 0x80)
        #expect(p.registers.n)
    }
    
    @Test
    mutating func tay() {
        p.registers.a = 0x80
        p.tay()
        #expect(p.registers.y == 0x80)
        #expect(p.registers.n)
    }
    
    @Test
    mutating func txa() {
        p.registers.x = 0x80
        p.txa()
        #expect(p.registers.a == 0x80)
        #expect(p.registers.n)
    }
    
    @Test
    mutating func tya() {
        p.registers.y = 0x80
        p.tya()
        #expect(p.registers.a == 0x80)
        #expect(p.registers.n)
    }
}
