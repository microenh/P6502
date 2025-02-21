//
//  BIT.swift
//  P6502Tests
//
//  Created by Mark Erbaugh on 2/21/25.
//

import Testing
@testable import P6502

struct BIT {
    var p = Model6502()
    
    @Test
    mutating func bit() {
        p.a = 0x80
        p.bit(value: 0x80)
        let r = p.registers
        #expect(!r.z)
        #expect(!r.o)
        #expect(r.n)
    }
    
    @Test
    mutating func bit1() {
        p.a = 0xc0
        p.bit(value: 0xc0)
        let r = p.registers
        #expect(!r.z)
        #expect(r.o)
        #expect(r.n)
    }
    
    @Test
    mutating func bit2() {
        p.a = 0x00
        p.bit(value: 0xc0)
        let r = p.registers
        #expect(r.z)
        #expect(!r.o)
        #expect(!r.n)
    }

}
