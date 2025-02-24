//
//  PushPop.swift
//  P6502Tests
//
//  Created by Mark Erbaugh on 2/22/25.
//

import Testing
@testable import P6502

struct Test {
    var p = Model6502()
    
    @Test
    mutating func push() {
        p.registers.sp = 0xff
        p.push(value: 0x80)
        #expect(p.memory[0x01ff] == 0x80)
        #expect(p.registers.sp == 0xfe)
    }
    
    @Test
    mutating func pop() {
        p.registers.sp = 0xfe
        p.memory[0x01ff] = 0x80
        #expect(p.pop() == 0x80)
        #expect(p.registers.sp == 0xff)
    }
    
    @Test
    mutating func pha() {
        p.registers.sp = 0xff
        p.registers.a = 0x80
        p.pha()
        #expect(p.memory[0x01ff] == 0x80)
    }
    
    @Test
    mutating func pla() {
        p.registers.sp = 0xfe
        p.memory[0x01ff] = 0x80
        p.pla()
        #expect(p.registers.a == 0x80)
    }
    
    @Test
    mutating func php() {
        p.registers.c = true
        p.registers.z = true
        p.registers.sp = 0xff
        p.php()
        #expect(p.memory[0x01ff] == 0b0010_0011)
    }
    
    @Test
    mutating func plp() {
        p.registers.sp = 0xfe
        p.memory[0x01ff] = 0b0010_0011
        p.plp()
        #expect(p.registers.c)
        #expect(p.registers.z)
    }
}
