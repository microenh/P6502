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
        p.registers.sp = 0x02
        p.push(value: 0xff)
        #expect(p.memory[0x0102] == 0xff)
        #expect(p.registers.sp == 0x03)
    }
    
    @Test
    mutating func pop() {
        p.registers.sp = 0x03
        p.memory[0x0102] = 0x80
        #expect(p.pop() == 0x80)
        #expect(p.registers.sp == 0x002)
    }
    
    @Test
    mutating func pha() {
        p.registers.sp = 0x02
        p.registers.a = 0x80
        p.pha()
        #expect(p.memory[0x0102] == 0x80)
    }
    
    @Test
    mutating func pla() {
        p.registers.sp = 0x03
        p.memory[0x102] = 0x80
        p.pla()
        #expect(p.registers.a == 0x80)
    }
    
    @Test
    mutating func php() {
        p.registers.c = true
        p.registers.z = true
        p.registers.sp = 0x02
        p.php()
        #expect(p.memory[0x0102] == 0b0010_0011)
    }
    
    @Test
    mutating func plp() {
        p.registers.sp = 0x03
        p.memory[0x102] = 0b0010_0011
        p.plp()
        #expect(p.registers.c)
        #expect(p.registers.z)
    }
}
