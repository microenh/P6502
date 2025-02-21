//
//  ASL.swift
//  P6502Tests
//
//  Created by Mark Erbaugh on 2/21/25.
//

import Testing
@testable import P6502

struct ASL {
    var p = Model6502()

    @Test
    mutating func asl() {
        var v = p.asl(value: 0x00)
        var r = p.registers
        #expect(v == 0x00)
        #expect(!r.c)
        #expect(!r.n)
        #expect(r.z)
        
        v = p.asl(value: 0x40)
        r = p.registers
        #expect(v == 0x80)
        #expect(!r.c)
        #expect(r.n)
        #expect(!r.z)

        v = p.asl(value: 0x81)
        r = p.registers
        #expect(v == 0x02)
        #expect(r.c)
        #expect(!r.n)
        #expect(!r.z)
    }
}
