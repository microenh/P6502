//
//  Compare.swift
//  P6502Tests
//
//  Created by Mark Erbaugh on 2/22/25.
//

import Testing
@testable import P6502

struct Compare {
    var p = Model6502()

    @Test
    mutating func compare() {
        p.registers.c = false
        p.registers.z = false
        p.registers.n = false
        
        p.compare(reg: 0x40, mem: 0x40)
        #expect(p.registers.c)
        #expect(p.registers.z)
        #expect(!p.registers.n)

        p.registers.c = false
        p.registers.z = false
        p.registers.n = false
        
        p.compare(reg: 0x41, mem: 0x40)
        #expect(p.registers.c)
        #expect(!p.registers.z)
        #expect(!p.registers.n)

        p.registers.c = false
        p.registers.z = false
        p.registers.n = false
        
        p.compare(reg: 0x3f, mem: 0x40)
        #expect(!p.registers.c)
        #expect(!p.registers.z)
        #expect(p.registers.n)
    }
    
    @Test
    mutating func cmp() {
        p.registers.c = false
        p.registers.z = false
        p.registers.n = false
        
        p.registers.a = 0x3f
        p.cmp(mem: 0x40)
        #expect(!p.registers.c)
        #expect(!p.registers.z)
        #expect(p.registers.n)
    }
    
    @Test
    mutating func cpx() {
        p.registers.c = false
        p.registers.z = false
        p.registers.n = false
        
        p.registers.x = 0x40
        p.cpx(mem: 0x40)
        #expect(p.registers.c)
        #expect(p.registers.z)
        #expect(!p.registers.n)
    }
    
    @Test
    mutating func cpy() {
        p.registers.c = false
        p.registers.z = false
        p.registers.n = false
        
        p.registers.y = 0x41
        p.cpy(mem: 0x40)
        #expect(p.registers.c)
        #expect(!p.registers.z)
        #expect(!p.registers.n)
    }
}
