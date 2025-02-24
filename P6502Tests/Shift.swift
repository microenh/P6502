//
//  Shift.swift
//  P6502Tests
//
//  Created by Mark Erbaugh on 2/21/25.
//

import Testing
@testable import P6502

struct Shift {
    var p = Model6502()
    
    static let testRange = [UInt8(0x00),0x01,0x02,0x04,0x08,0x10,0x20,0x40,0x80,0xff]
    
    @Test(arguments: testRange)
    mutating func asl(value: UInt8) {
        let v = p.asl(value: value)
        let vs = Int(value) << 1
        #expect(v == UInt8(truncatingIfNeeded: vs))
        #expect(p.registers.c == ((value & 0x80) > 0))
        #expect(p.registers.z == (UInt8(truncatingIfNeeded: vs) == 0))
        #expect(p.registers.n == ((vs & 0x80) > 0))
    }
    
    @Test(arguments: testRange)
    mutating func lsr(value: UInt8) {
        let v = p.lsr(value: value)
        let vs = value >> 1
        #expect(v == vs)
        #expect(p.registers.c == ((value & 0x01) > 0))
        #expect(!p.registers.n)
        #expect(p.registers.z == (vs == 0))
    }
    
    @Test(arguments: testRange)
    mutating func rol(value: UInt8) {
        p.registers.c = false
        let v = p.rol(value: value)
        let vs = Int(value) << 1
        #expect(v == UInt8(truncatingIfNeeded: vs))
        #expect(p.registers.c == ((value & 0x80) > 0))
        #expect(p.registers.z == (v == 0))
        #expect(p.registers.n == (v >= 0x80))
    }
    
    @Test(arguments: testRange)
    mutating func rolC(value: UInt8) {
        p.registers.c = true
        let v = p.rol(value: value)
        let vs = Int(value) << 1 | 1
        #expect(v == UInt8(truncatingIfNeeded: vs))
        #expect(p.registers.c == ((value & 0x80) > 0))
        #expect(p.registers.z == (v == 0))
        #expect(p.registers.n == (v >= 0x80))
    }
    
    @Test(arguments: testRange)
    mutating func ror(value: UInt8) {
        p.registers.c = false
        let v = p.ror(value: value)
        let vs = value >> 1
        #expect(v == UInt8(truncatingIfNeeded: vs))
        #expect(p.registers.c == ((value & 0x01) > 0))
        #expect(p.registers.z == (v == 0))
        #expect(p.registers.n == (v >= 0x80))
    }
    
    @Test(arguments: testRange)
    mutating func rorC(value: UInt8) {
        p.registers.c = true
        let v = p.ror(value: value)
        let vs = value >> 1 | 0x80
        #expect(v == UInt8(truncatingIfNeeded: vs))
        #expect(p.registers.c == ((value & 0x01) > 0))
        #expect(p.registers.z == (v == 0))
        #expect(p.registers.n == (v >= 0x80))
    }
}
