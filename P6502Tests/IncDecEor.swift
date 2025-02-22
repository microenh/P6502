//
//  IncDec.swift
//  P6502Tests
//
//  Created by Mark Erbaugh on 2/22/25.
//

import Testing
@testable import P6502

struct IncDec {
    var p = Model6502()
    
    mutating func incTest(value: UInt8, res: UInt8, z: Bool, n: Bool) {
        p.registers.z = false
        p.registers.n = false
        let r = p.inc(value: value)
        #expect(r == res)
        #expect(p.registers.z == z)
        #expect(p.registers.n == n)
    }

    @Test
    mutating func inc() {
        incTest(value: 0x01, res: 0x02, z: false, n: false)
        incTest(value: 0xff, res: 0x00, z: true, n: false)
        incTest(value: 0x7f, res: 0x80, z: false, n: true)
    }
    
    @Test
    mutating func inx() async throws {
        p.registers.z = false
        p.registers.n = false
        p.registers.x = 0x7f
        p.inx()
        #expect(p.registers.x == 0x80)
        #expect(!p.registers.z)
        #expect(p.registers.n)
    }

    @Test
    mutating func iny() async throws {
        p.registers.z = false
        p.registers.n = false
        p.registers.y = 0xff
        p.iny()
        #expect(p.registers.y == 0x00)
        #expect(p.registers.z)
        #expect(!p.registers.n)
    }
    
    mutating func decTest(value: UInt8, res: UInt8, z: Bool, n: Bool) {
        p.registers.z = false
        p.registers.n = false
        let r = p.dec(value: value)
        #expect(r == res)
        #expect(p.registers.z == z)
        #expect(p.registers.n == n)
    }

    @Test
    mutating func decc() {
        decTest(value: 0x02, res: 0x01, z: false, n: false)
        decTest(value: 0x01, res: 0x00, z: true, n: false)
        decTest(value: 0x81, res: 0x80, z: false, n: true)
    }

    @Test
    mutating func dex() async throws {
        p.registers.z = false
        p.registers.n = false
        p.registers.x = 0x81
        p.dex()
        #expect(p.registers.x == 0x80)
        #expect(!p.registers.z)
        #expect(p.registers.n)
    }

    @Test
    mutating func dey() async throws {
        p.registers.z = false
        p.registers.n = false
        p.registers.y = 0x01
        p.dey()
        #expect(p.registers.y == 0x00)
        #expect(p.registers.z)
        #expect(!p.registers.n)
    }
    
    @Test
    mutating func eor() async throws {
        p.registers.a = 0b1010_1010
        p.eor(value: 0b1010_1010)
        #expect(p.registers.a == 0x00)
        #expect(p.registers.z)
        #expect(!p.registers.n)
    }
}
