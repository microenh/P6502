//
//  BRK.swift
//  P6502Tests
//
//  Created by Mark Erbaugh on 2/22/25.
//

import Testing
@testable import P6502

struct BRK {
    var p = Model6502()

    @Test
    mutating func brk() {
        p.memory[0xfffe] = 0x02
        p.memory[0xffff] = 0xc0
        p.registers.pc = 0x1234
        p.registers.sp = 0x02
        p.registers.c = true
        p.registers.z = false
        p.registers.i = false
        p.registers.d = false
        p.registers.b = false
        p.registers.o = false
        p.registers.n = false
        p.brk()
        #expect(p.registers.pc == 0xc002)
        #expect(p.registers.sp == 0x05)
        #expect(p.memory[0x0102] == 0x34)
        #expect(p.memory[0x0103] == 0x12)
        #expect(p.memory[0x0104] == 0x21)
        #expect(p.registers.c)
        #expect(!p.registers.z)
        #expect(!p.registers.i)
        #expect(!p.registers.d)
        #expect(p.registers.b)
        #expect(!p.registers.o)
        #expect(!p.registers.n)
    }
}
