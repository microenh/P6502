//
//  JmpJsr.swift
//  P6502Tests
//
//  Created by Mark Erbaugh on 2/22/25.
//

import Testing
@testable import P6502

struct JmpJsr {
    var p = Model6502()
    
    @Test
    mutating func jmpAbsolute() async throws {
        p.registers.pc = 0xf000
        p.jmpAbsolute(addr: 0x0300)
        #expect(p.registers.pc == 0x0300)
    }
    
    @Test
    mutating func jmpIndirect() async throws {
        p.registers.pc = 0xf000
        p.memory[0x0300] = 0x80
        p.memory[0x0301] = 0x90
        p.jmpIndirect(addr: 0x0300)
        #expect(p.registers.pc == 0x9080)
    }
    
    @Test
    mutating func jmpIndirectBug() async throws {
        p.registers.pc = 0xf000
        p.memory[0x03ff] = 0x80
        p.memory[0x0300] = 0x90
        p.jmpIndirect(addr: 0x03ff)
        #expect(p.registers.pc == 0x9080)
    }
    
    @Test
    mutating func jsr() {
        p.registers.sp = 0xff
        p.registers.pc = 0xb004
        p.jsr(addr: 0xc004)
        
        #expect(p.memory[0x01ff] == 0x05)
        #expect(p.memory[0x01fe] == 0xb0)
        #expect(p.registers.sp == 0xfd)
        #expect(p.registers.pc == 0xc004)
    }

    @Test
    mutating func rts()  {
        p.registers.sp = 0xfd
        p.registers.pc = 0xc004
        p.memory[0x01ff] = 0x05
        p.memory[0x01fe] = 0xb0
        p.rts()
        #expect(p.registers.pc == 0xb006)
        #expect(p.registers.sp == 0xff)
    }
    
    @Test
    mutating func rti() {
        p.registers.sp = 0xfc
        p.memory[0x01fd] = 0b0010_0011
        p.memory[0x01fe] = 0xb0
        p.memory[0x01ff] = 0x01
        p.rti()
        #expect(p.registers.pc == 0xb001)
        #expect(p.registers.c)
        #expect(p.registers.z)
        #expect(!p.registers.n)
    }
    
}
