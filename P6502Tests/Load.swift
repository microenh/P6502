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
        #expect(Model6502.zeroNegativeFlags(value: 0x00) == (zero: true, negative: false))
        #expect(Model6502.zeroNegativeFlags(value: 0x01) == (zero: false, negative: false))
        #expect(Model6502.zeroNegativeFlags(value: 0x80) == (zero: false, negative: true))
    }
    
    @Test
    mutating func loadA() {
        p.a = 0
        var r = p.registers
        #expect(r.a == 0)
        #expect(r.z)
        #expect(!r.n)
        
        p.a = 1
        r = p.registers
        #expect(r.a == 1)
        #expect(!r.z)
        #expect(!r.n)
        
        p.a = 0x80
        r = p.registers
        #expect(r.a == 0x80)
        #expect(!r.z)
        #expect(r.n)
    }
    
    @Test
    mutating func loadX() {
        p.x = 0
        var r = p.registers
        #expect(r.x == 0)
        #expect(r.z)
        #expect(!r.n)
        
        p.x = 1
        r = p.registers
        #expect(r.x == 1)
        #expect(!r.z)
        #expect(!r.n)
        
        p.x = 0x80
        r = p.registers
        #expect(r.x == 0x80)
        #expect(!r.z)
        #expect(r.n)
    }
    
    @Test
    mutating func loadY() {
        p.y = 0
        var r = p.registers
        #expect(r.y == 0)
        #expect(r.z)
        #expect(!r.n)
        
        p.y = 1
        r = p.registers
        #expect(r.y == 1)
        #expect(!r.z)
        #expect(!r.n)
        
        p.y = 0x80
        r = p.registers
        #expect(r.y == 0x80)
        #expect(!r.z)
        #expect(r.n)
    }
    
    @Test func twosComplement() async throws {
        #expect(Model6502.twosComplement(value: 0x00) == 0x00)
        #expect(Model6502.twosComplement(value: 0x01) == 0x01)
        #expect(Model6502.twosComplement(value: 0x79) == 0x79)
        #expect(Model6502.twosComplement(value: 0x80) == -128)
        #expect(Model6502.twosComplement(value: 0x81) == -127)
        #expect(Model6502.twosComplement(value: 0xff) == -1)
    }
}
