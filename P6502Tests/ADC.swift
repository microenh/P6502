//
//  ADC.swift
//  P6502Tests
//
//  Created by Mark Erbaugh on 2/18/25.
//

import Testing
@testable import P6502

struct ADC {
    var p = Model6502()
    
    @Test
    mutating func simple() {
        p.c = false
        p.d = false
        p.a = 0x10
        p.adc(add: 0x10)
        let r = p.registers
        #expect(r.a == 0x20)
        #expect(!r.c)
        #expect(!r.z)
        #expect(!r.n)
        #expect(!r.o)
    }

    @Test
    mutating func carry() {
        p.c = false
        p.d = false
        p.a = 0xf0
        p.adc(add: 0x10)
        let r = p.registers
        #expect(r.a == 0x00)
        #expect(r.c)
        #expect(r.z)
        #expect(!r.n)
        #expect(!r.o)
    }

    @Test
    mutating func negative() {
        p.c = false
        p.d = false
        p.a = 0x7f
        p.adc(add: 0x01)
        let r = p.registers
        #expect(r.a == 0x80)
        #expect(!r.c)
        #expect(!r.z)
        #expect(r.n)
        #expect(r.o)
    }
    
    @Test
    mutating func overflow() {
        p.d = false
        p.c = false
        p.a = 0x7f
        p.adc(add: 0x01)
        var r = p.registers
        #expect(r.o)
        
        p.c = false
        p.a = 0x80
        p.adc(add: 0xff)
        r = p.registers
        #expect(r.o)
    }

    @Test
    mutating func simpleC() {
        p.c = true
        p.d = false
        p.a = 0x10
        p.adc(add: 0x10)
        let r = p.registers
        #expect(r.a == 0x21)
        #expect(!r.c)
        #expect(!r.z)
        #expect(!r.n)
        #expect(!r.o)
    }

    @Test
    mutating func carryC() {
        p.c = true
        p.d = false
        p.a = 0xf0
        p.adc(add: 0x0f)
        let r = p.registers
        #expect(r.a == 0x00)
        #expect(r.c)
        #expect(r.z)
        #expect(!r.n)
        #expect(!r.o)
    }
    
    @Test
    mutating func negativeC() {
        p.c = true
        p.d = false
        p.a = 0x7e
        p.adc(add: 0x01)
        let r = p.registers
        #expect(r.a == 0x80)
        #expect(!r.c)
        #expect(!r.z)
        #expect(r.n)
        #expect(r.o)
    }
    
    @Test
    mutating func overflowC() {
        p.d = false
        p.c = true
        p.a = 0x7f
        p.adc(add: 0x01)
        var r = p.registers
        #expect(r.o)
        
        p.c = true
        p.a = 0x80
        p.adc(add: 0xfe)
        r = p.registers
        #expect(r.o)
    }
    
    @Test
    mutating func overflow2() {
        p.d = false
        p.c = false
        p.a = 0x50
        p.adc(add: 0x50)
        var r = p.registers
        #expect(r.o)
        
        p.c = false
        p.a = 0xd0
        p.adc(add: 0x90)
        r = p.registers
        #expect(r.o)
    }
    
    @Test
    mutating func decimal() {
        // behavior of N,Z flags undefined
        p.d = true
        p.c = false
        p.a = 0x09
        p.adc(add: 0x01)
        var r = p.registers
        #expect(r.a == 0x10)
        #expect(!r.c)

        p.c = true
        p.a = 0x09
        p.adc(add: 0x01)
        r = p.registers
        #expect(r.a == 0x11)
        #expect(!r.c)

        p.c = true
        p.a = 0x99
        p.adc(add: 0x01)
        r = p.registers
        #expect(r.a == 0x01)
        #expect(r.c)
    }
}
