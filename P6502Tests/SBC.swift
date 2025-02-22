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
        p.registers.d = false
        p.registers.c = true
        p.registers.a = 0xff
        p.sbc(sub: 0x01)
        #expect(p.registers.a == 0xfe)
        #expect(p.registers.c)
        #expect(!p.registers.z)
    }
    
    @Test
    mutating func borrow() {
        p.registers.d = false
        p.registers.c = true
        p.registers.a = 0x00
        p.sbc(sub: 0x01)
        #expect(p.registers.a == 0xff)
        #expect(!p.registers.c)
        #expect(!p.registers.z)
    }
    
    @Test
    mutating func zero() {
        p.registers.d = false
        p.registers.c = true
        p.registers.a = 0x01
        p.sbc(sub: 0x01)
        #expect(p.registers.a == 0x00)
        #expect(p.registers.c)
        #expect(p.registers.z)
    }
    
    @Test
    mutating func simpleC() {
        p.registers.d = false
        p.registers.c = false
        p.registers.a = 0x02
        p.sbc(sub: 0x01)
        #expect(p.registers.a == 0x00)
        #expect(p.registers.c)
        #expect(p.registers.z)
    }
    
    @Test
    mutating func overflow() {
        p.registers.d = false
        p.registers.c = true
        p.registers.a = 0x00
        p.sbc(sub: 0x01)
        #expect(p.registers.a == 0xff)
        #expect(!p.registers.c)
        #expect(!p.registers.z)
        #expect(!p.registers.o)
    }
    
    @Test
    mutating func overflow2() {
        p.registers.d = false
        p.registers.c = true
        p.registers.a = 0x80
        p.sbc(sub: 0x01)
        #expect(p.registers.a == 0x7f)
        #expect(p.registers.c)
        #expect(!p.registers.z)
        #expect(p.registers.o)
    }
    
    @Test
    mutating func overflow3() {
        p.registers.d = false
        p.registers.c = true
        p.registers.a = 0x7f
        p.sbc(sub: 0xff)
        #expect(p.registers.a == 0x80)
        #expect(!p.registers.c)
        #expect(!p.registers.z)
        #expect(p.registers.o)
    }
    
    @Test
    mutating func overflow4() {
        p.registers.d = false
        p.registers.c = true
        p.registers.a = 0x50
        p.sbc(sub: 0xb0)
        #expect(p.registers.a == 0xa0)
        #expect(!p.registers.c)
        #expect(!p.registers.z)
        #expect(p.registers.o)
    }
    
    @Test
    mutating func overflow5() {
        p.registers.d = false
        p.registers.c = true
        p.registers.a = 0xd0
        p.sbc(sub: 0x70)
        #expect(p.registers.a == 0x60)
        #expect(p.registers.c)
        #expect(!p.registers.z)
        #expect(p.registers.o)
    }
    
    @Test
    mutating func decimal() async throws {
        p.registers.d = true
        p.registers.c = true
        p.registers.a = 0x91
        p.sbc(sub: 0x02)
        #expect(p.registers.a == 0x89)
        #expect(p.registers.c)
        #expect(!p.registers.z)
        #expect(!p.registers.o)
    }
    
    @Test
    mutating func decimalUnderflow() async throws {
        p.registers.d = true
        p.registers.c = true
        p.registers.a = 0x02
        p.sbc(sub: 0x91)
        #expect(p.registers.a == 0x11)
        #expect(!p.registers.c)
        #expect(!p.registers.z)
        #expect(!p.registers.o)
    }
    
    @Test
    mutating func decimalBorrow() async throws {
        p.registers.d = true
        p.registers.c = false
        p.registers.a = 0x92
        p.sbc(sub: 0x02)
        #expect(p.registers.a == 0x89)
        #expect(p.registers.c)
        #expect(!p.registers.z)
        #expect(!p.registers.o)
    }
    
    @Test
    mutating func decimalBorrowUnderflow() async throws {
        p.registers.d = true
        p.registers.c = false
        p.registers.a = 0x03
        p.sbc(sub: 0x91)
        #expect(p.registers.a == 0x11)
        #expect(!p.registers.c)
        #expect(!p.registers.z)
        #expect(!p.registers.o)
    }
}
