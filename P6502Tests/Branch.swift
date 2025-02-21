//
//  Branch.swift
//  P6502Tests
//
//  Created by Mark Erbaugh on 2/21/25.
//

import Testing
@testable import P6502

struct Branch {
    var p = Model6502()
    
    @Test
    mutating func branch() async throws {
        p.pc = 0x8000
        p.branch(flag: true, offset: 0x50)
        var r = p.registers
        #expect(r.pc == 0x8050)
        
        p.pc = 0x8000
        p.branch(flag: true, offset: 0xf0)
        r = p.registers
        #expect(r.pc == 0x7ff0)
        
        p.pc = 0x8000
        p.branch(flag: false, offset: 0xf0)
        r = p.registers
        #expect(r.pc == 0x8000)
    }
    
    @Test
    mutating func bcc() async throws {
        p.pc = 0x8000
        p.c = false
        p.bcc(offset: 0x50)
        let r = p.registers
        #expect(r.pc == 0x8050)
    }
    
    @Test
    mutating func bcs() async throws {
        p.pc = 0x8000
        p.c = true
        p.bcs(offset: 0x50)
        let r = p.registers
        #expect(r.pc == 0x8050)
    }
    
    @Test
    mutating func beq() async throws {
        p.pc = 0x8000
        p.z = true
        p.beq(offset: 0x50)
        let r = p.registers
        #expect(r.pc == 0x8050)
    }
    
    @Test
    mutating func bne() async throws {
        p.pc = 0x8000
        p.z = false
        p.bne(offset: 0x50)
        let r = p.registers
        #expect(r.pc == 0x8050)
    }

    @Test
    mutating func bmi() async throws {
        p.pc = 0x8000
        p.n = true
        p.bmi(offset: 0x50)
        let r = p.registers
        #expect(r.pc == 0x8050)
    }
    
    @Test
    mutating func bpl() async throws {
        p.pc = 0x8000
        p.n = false
        p.bpl(offset: 0x50)
        let r = p.registers
        #expect(r.pc == 0x8050)
    }

    @Test
    mutating func bvc() async throws {
        p.pc = 0x8000
        p.o = false
        p.bvc(offset: 0x50)
        let r = p.registers
        #expect(r.pc == 0x8050)
    }
    
    @Test
    mutating func bvs() async throws {
        p.pc = 0x8000
        p.o = true
        p.bvs(offset: 0x50)
        let r = p.registers
        #expect(r.pc == 0x8050)
    }
}
