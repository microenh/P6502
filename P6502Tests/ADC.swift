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
        p.registers.c = false
        p.registers.d = false
        p.registers.a = 0x10
        p.adc(add: 0x10)
        #expect(p.registers.a == 0x20)
        #expect(!p.registers.c)
        #expect(!p.registers.z)
        #expect(!p.registers.n)
        #expect(!p.registers.o)
    }

    @Test
    mutating func carry() {
        p.registers.c = false
        p.registers.d = false
        p.registers.a = 0xf0
        p.adc(add: 0x10)
        #expect(p.registers.a == 0x00)
        #expect(p.registers.c)
        #expect(p.registers.z)
        #expect(!p.registers.n)
        #expect(!p.registers.o)
    }

    @Test
    mutating func negative() {
        p.registers.c = false
        p.registers.d = false
        p.registers.a = 0x7f
        p.adc(add: 0x01)
        #expect(p.registers.a == 0x80)
        #expect(!p.registers.c)
        #expect(!p.registers.z)
        #expect(p.registers.n)
        #expect(p.registers.o)
    }
    
    @Test
    mutating func overflow() {
        p.registers.d = false
        p.registers.c = false
        p.registers.a = 0x7f
        p.adc(add: 0x01)
        #expect(p.registers.o)
        
        p.registers.c = false
        p.registers.a = 0x80
        p.adc(add: 0xff)
        #expect(p.registers.o)
    }

    @Test
    mutating func simpleC() {
        p.registers.c = true
        p.registers.d = false
        p.registers.a = 0x10
        p.adc(add: 0x10)
        #expect(p.registers.a == 0x21)
        #expect(!p.registers.c)
        #expect(!p.registers.z)
        #expect(!p.registers.n)
        #expect(!p.registers.o)
    }

    @Test
    mutating func carryC() {
        p.registers.c = true
        p.registers.d = false
        p.registers.a = 0xf0
        p.adc(add: 0x0f)
        #expect(p.registers.a == 0x00)
        #expect(p.registers.c)
        #expect(p.registers.z)
        #expect(!p.registers.n)
        #expect(!p.registers.o)
    }
    
    @Test
    mutating func negativeC() {
        p.registers.c = true
        p.registers.d = false
        p.registers.a = 0x7e
        p.adc(add: 0x01)
        #expect(p.registers.a == 0x80)
        #expect(!p.registers.c)
        #expect(!p.registers.z)
        #expect(p.registers.n)
        #expect(p.registers.o)
    }
    
    @Test
    mutating func overflowC() {
        p.registers.d = false
        p.registers.c = true
        p.registers.a = 0x7f
        p.adc(add: 0x01)
        #expect(p.registers.o)
        
        p.registers.c = true
        p.registers.a = 0x80
        p.adc(add: 0xfe)
        #expect(p.registers.o)
    }
    
    @Test
    mutating func overflow2() {
        p.registers.d = false
        p.registers.c = false
        p.registers.a = 0x50
        p.adc(add: 0x50)
        #expect(p.registers.o)
        
        p.registers.c = false
        p.registers.a = 0xd0
        p.adc(add: 0x90)
        #expect(p.registers.o)
    }
    
    @Test
    mutating func decimal() {
        // behavior of N,Z flags undefined
        p.registers.d = true
        p.registers.c = false
        p.registers.a = 0x09
        p.adc(add: 0x01)
        #expect(p.registers.a == 0x10)
        #expect(!p.registers.c)

        p.registers.c = true
        p.registers.a = 0x09
        p.adc(add: 0x01)
        #expect(p.registers.a == 0x11)
        #expect(!p.registers.c)

        p.registers.c = true
        p.registers.a = 0x99
        p.adc(add: 0x01)
        #expect(p.registers.a == 0x01)
        #expect(p.registers.c)
    }
}
