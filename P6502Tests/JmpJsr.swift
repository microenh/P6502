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

}
