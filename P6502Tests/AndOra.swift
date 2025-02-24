//
//  AndOra.swift
//  P6502Tests
//
//  Created by Mark Erbaugh on 2/21/25.
//

import Testing
@testable import P6502

struct AND {
    var p = Model6502()

    @Test
    mutating func and() {
        p.registers.a = 0xff
        p.and(value: 0x00)
        #expect(p.registers.a == 0x00)
        #expect(p.registers.z)
        #expect(!p.registers.n)

        p.registers.a = 0xff
        p.and(value: 0x80)
        #expect(p.registers.a == 0x80)
        #expect(!p.registers.z)
        #expect(p.registers.n)
    }

    @Test
    mutating func ora() {
        p.registers.a = 0xff
        p.ora(value: 0x00)
        #expect(p.registers.a == 0xff)
        #expect(!p.registers.z)
        #expect(p.registers.n)

        p.registers.a = 0x00
        p.ora(value: 0x80)
        #expect(p.registers.a == 0x80)
        #expect(!p.registers.z)
        #expect(p.registers.n)
    }
}
