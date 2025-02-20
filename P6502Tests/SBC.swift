//
//  SBC.swift
//  P6502Tests
//
//  Created by Mark Erbaugh on 2/19/25.
//

import Testing
@testable import P6502

struct SBC {
    var p = Model6502()
    
    @Test
    mutating func simple() {
        p.d = false
        p.c = true
        p.a = 0xff
        p.sbc(sub: 0x01)
        let r = p.registers
        #expect(r.a == 0xfe)
        #expect(r.c)
        #expect(!r.z)
    }
    
    @Test
    mutating func borrow() {
        p.d = false
        p.c = true
        p.a = 0x00
        p.sbc(sub: 0x01)
        let r = p.registers
        #expect(r.a == 0xff)
        #expect(!r.c)
        #expect(!r.z)
    }
    
    @Test
    mutating func zero() {
        p.d = false
        p.c = true
        p.a = 0x01
        p.sbc(sub: 0x01)
        let r = p.registers
        #expect(r.a == 0x00)
        #expect(r.c)
        #expect(r.z)
    }
    
    @Test
    mutating func simpleC() {
        p.d = false
        p.c = false
        p.a = 0x02
        p.sbc(sub: 0x01)
        let r = p.registers
        #expect(r.a == 0x00)
        #expect(r.c)
        #expect(r.z)
    }
    
    @Test
    mutating func overflow() {
        p.d = false
        p.c = true
        p.a = 0x00
        p.sbc(sub: 0x01)
        let r = p.registers
        #expect(r.a == 0xff)
        #expect(!r.c)
        #expect(!r.z)
        #expect(!r.o)
    }
    
    @Test
    mutating func overflow2() {
        p.d = false
        p.c = true
        p.a = 0x80
        p.sbc(sub: 0x01)
        let r = p.registers
        #expect(r.a == 0x7f)
        #expect(r.c)
        #expect(!r.z)
        #expect(r.o)
    }
    
    @Test
    mutating func overflow3() {
        p.d = false
        p.c = true
        p.a = 0x7f
        p.sbc(sub: 0xff)
        let r = p.registers
        #expect(r.a == 0x80)
        #expect(!r.c)
        #expect(!r.z)
        #expect(r.o)
    }
    
    @Test
    mutating func overflow4() {
        p.d = false
        p.c = true
        p.a = 0x50
        p.sbc(sub: 0xb0)
        let r = p.registers
        #expect(r.a == 0xa0)
        #expect(!r.c)
        #expect(!r.z)
        #expect(r.o)
    }
    
    @Test
    mutating func overflow5() {
        p.d = false
        p.c = true
        p.a = 0xd0
        p.sbc(sub: 0x70)
        let r = p.registers
        #expect(r.a == 0x60)
        #expect(r.c)
        #expect(!r.z)
        #expect(r.o)
    }
    
    @Test
    mutating func decimal() async throws {
        p.d = true
        p.c = true
        p.a = 0x91
        p.sbc(sub: 0x02)
        let r = p.registers
        #expect(r.a == 0x89)
        #expect(r.c)
        #expect(!r.z)
        #expect(!r.o)
    }
    
    @Test
    mutating func decimalUnderflow() async throws {
        p.d = true
        p.c = true
        p.a = 0x02
        p.sbc(sub: 0x91)
        let r = p.registers
        #expect(r.a == 0x11)
        #expect(!r.c)
        #expect(!r.z)
        #expect(!r.o)
    }
    
    @Test
    mutating func decimalBorrow() async throws {
        p.d = true
        p.c = false
        p.a = 0x92
        p.sbc(sub: 0x02)
        let r = p.registers
        #expect(r.a == 0x89)
        #expect(r.c)
        #expect(!r.z)
        #expect(!r.o)
    }
    
    @Test
    mutating func decimalBorrowUnderflow() async throws {
        p.d = true
        p.c = false
        p.a = 0x03
        p.sbc(sub: 0x91)
        let r = p.registers
        #expect(r.a == 0x11)
        #expect(!r.c)
        #expect(!r.z)
        #expect(!r.o)
    }
}
