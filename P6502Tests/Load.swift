//
//  Load.swift
//  P6502Tests
//
//  Created by Mark Erbaugh on 2/18/25.
//

import Testing
@testable import P6502

struct Load {
    var p = Model6502()
    
    @Test func zeroNegativeFlags() {
        #expect(P6502.zeroNegativeFlags(value: 0x00) == (zero: true, negative: false))
        #expect(P6502.zeroNegativeFlags(value: 0x01) == (zero: false, negative: false))
        #expect(P6502.zeroNegativeFlags(value: 0x80) == (zero: false, negative: true))
    }
    
    @Test
    mutating func loadA() {
        p.registers.a = 0
        #expect(p.registers.a == 0)
        #expect(p.registers.z)
        #expect(!p.registers.n)
        
        p.registers.a = 1
        #expect(p.registers.a == 1)
        #expect(!p.registers.z)
        #expect(!p.registers.n)
        
        p.registers.a = 0x80
        #expect(p.registers.a == 0x80)
        #expect(!p.registers.z)
        #expect(p.registers.n)
    }
    
    @Test
    mutating func loadX() {
        p.registers.x = 0
        #expect(p.registers.x == 0)
        #expect(p.registers.z)
        #expect(!p.registers.n)
        
        p.registers.x = 1
        #expect(p.registers.x == 1)
        #expect(!p.registers.z)
        #expect(!p.registers.n)
        
        p.registers.x = 0x80
        #expect(p.registers.x == 0x80)
        #expect(!p.registers.z)
        #expect(p.registers.n)
    }
    
    @Test
    mutating func loadY() {
        p.registers.y = 0
        #expect(p.registers.y == 0)
        #expect(p.registers.z)
        #expect(!p.registers.n)
        
        p.registers.y = 1
        #expect(p.registers.y == 1)
        #expect(!p.registers.z)
        #expect(!p.registers.n)
        
        p.registers.y = 0x80
        #expect(p.registers.y == 0x80)
        #expect(!p.registers.z)
        #expect(p.registers.n)
    }
    
    @Test
    mutating func flags() async throws {
        p.registers.c = false
        p.registers.z = false
        p.registers.i = false
        p.registers.d = false
        p.registers.b = false
        p.registers.o = false
        p.registers.n = false
        #expect(p.registers.flags == 0x20)
        
        p.registers.c = true
        p.registers.z = false
        p.registers.i = false
        p.registers.d = false
        p.registers.b = false
        p.registers.o = false
        p.registers.n = false
        #expect(p.registers.flags == 0x21)
        
        p.registers.c = false
        p.registers.z = true
        p.registers.i = false
        p.registers.d = false
        p.registers.b = false
        p.registers.o = false
        p.registers.n = false
        #expect(p.registers.flags == 0x22)

        p.registers.c = false
        p.registers.z = false
        p.registers.i = true
        p.registers.d = false
        p.registers.b = false
        p.registers.o = false
        p.registers.n = false
        #expect(p.registers.flags == 0x24)
        
        p.registers.c = false
        p.registers.z = false
        p.registers.i = false
        p.registers.d = true
        p.registers.b = false
        p.registers.o = false
        p.registers.n = false
        #expect(p.registers.flags == 0x28)
        
        p.registers.c = false
        p.registers.z = false
        p.registers.i = false
        p.registers.d = false
        p.registers.b = true
        p.registers.o = false
        p.registers.n = false
        #expect(p.registers.flags == 0x30)
        
        p.registers.c = false
        p.registers.z = false
        p.registers.i = false
        p.registers.d = false
        p.registers.b = false
        p.registers.o = true
        p.registers.n = false
        #expect(p.registers.flags == 0x60)
        
        p.registers.c = false
        p.registers.z = false
        p.registers.i = false
        p.registers.d = false
        p.registers.b = false
        p.registers.o = false
        p.registers.n = true
        #expect(p.registers.flags == 0xa0)
     }
    
    @Test
    mutating func getFlags() {
        p.registers.flags = 0x00
        #expect(!p.registers.c)
        #expect(!p.registers.z)
        #expect(!p.registers.i)
        #expect(!p.registers.d)
        #expect(!p.registers.b)
        #expect(!p.registers.o)
        #expect(!p.registers.n)

        p.registers.flags = 0x01
        #expect(p.registers.c)
        #expect(!p.registers.z)
        #expect(!p.registers.i)
        #expect(!p.registers.d)
        #expect(!p.registers.b)
        #expect(!p.registers.o)
        #expect(!p.registers.n)

        p.registers.flags = 0x2
        #expect(!p.registers.c)
        #expect(p.registers.z)
        #expect(!p.registers.i)
        #expect(!p.registers.d)
        #expect(!p.registers.b)
        #expect(!p.registers.o)
        #expect(!p.registers.n)

        p.registers.flags = 0x04
        #expect(!p.registers.c)
        #expect(!p.registers.z)
        #expect(p.registers.i)
        #expect(!p.registers.d)
        #expect(!p.registers.b)
        #expect(!p.registers.o)
        #expect(!p.registers.n)

        p.registers.flags = 0x08
        #expect(!p.registers.c)
        #expect(!p.registers.z)
        #expect(!p.registers.i)
        #expect(p.registers.d)
        #expect(!p.registers.b)
        #expect(!p.registers.o)
        #expect(!p.registers.n)

        p.registers.flags = 0x10
        #expect(!p.registers.c)
        #expect(!p.registers.z)
        #expect(!p.registers.i)
        #expect(!p.registers.d)
        #expect(p.registers.b)
        #expect(!p.registers.o)
        #expect(!p.registers.n)

        p.registers.flags = 0x40
        #expect(!p.registers.c)
        #expect(!p.registers.z)
        #expect(!p.registers.i)
        #expect(!p.registers.d)
        #expect(!p.registers.b)
        #expect(p.registers.o)
        #expect(!p.registers.n)

        p.registers.flags = 0x80
        #expect(!p.registers.c)
        #expect(!p.registers.z)
        #expect(!p.registers.i)
        #expect(!p.registers.d)
        #expect(!p.registers.b)
        #expect(!p.registers.o)
        #expect(p.registers.n)
    }
    
    @Test func twosComplement() async throws {
        #expect(P6502.twosComplement(value: 0x00) == 0x00)
        #expect(P6502.twosComplement(value: 0x01) == 0x01)
        #expect(P6502.twosComplement(value: 0x79) == 0x79)
        #expect(P6502.twosComplement(value: 0x80) == -128)
        #expect(P6502.twosComplement(value: 0x81) == -127)
        #expect(P6502.twosComplement(value: 0xff) == -1)
    }
}
