//
//  AND.swift
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
        p.a = 0xff
        p.and(value: 0x00)
        var r = p.registers
        #expect(r.a == 0x00)
        #expect(r.z)
        #expect(!r.n)

        p.a = 0xff
        p.and(value: 0x80)
        r = p.registers
        #expect(r.a == 0x80)
        #expect(!r.z)
        #expect(r.n)
    }

}
